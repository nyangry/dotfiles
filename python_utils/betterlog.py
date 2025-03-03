import inspect as inspect_module
import logging
import os
from typing import Any, Dict, List, Optional


class Betterlog:
    """A simple utility to inspect and display internal structure of Python objects"""

    def __init__(self, name=None, project_root=None):
        """Initialize the inspector"""
        self.name = name or "betterlog"
        self.level = logging.INFO  # Fixed to INFO level
        self.max_width = 120  # Default table width
        self.project_root = project_root  # Store project root for relative paths

        # Auto-detect project root if not specified
        if self.project_root is None:
            self.project_root = self._detect_project_root()

        # Configure standard logger
        self.logger = logging.getLogger(self.name)
        if not self.logger.handlers:
            handler = logging.StreamHandler()
            formatter = logging.Formatter(
                "%(asctime)s - %(name)s - %(levelname)s - %(message)s"
            )
            handler.setFormatter(formatter)
            self.logger.addHandler(handler)

        self.logger.setLevel(self.level)

    def get_caller_info(self) -> str:
        """Get caller information (file, function, line number)"""
        # Current frame -> inspect_multi -> log -> actual caller
        frame = inspect_module.currentframe()

        # Go up the frame stack to find the actual caller (outside of this module)
        module_name = frame.f_globals.get("__name__", "")
        caller_frame = frame

        # Skip frames within this module
        for _ in range(10):  # Limit to prevent infinite loop
            if caller_frame is None:
                break

            caller_frame = caller_frame.f_back
            if caller_frame is None:
                break

            # If we're outside this module, we found our caller
            if caller_frame.f_globals.get("__name__", "") != module_name:
                break

        if caller_frame is None:
            return "Unknown location"

        filename = caller_frame.f_code.co_filename
        lineno = caller_frame.f_lineno
        function_name = caller_frame.f_code.co_name

        # Convert to relative path if project_root is set
        if self.project_root and filename.startswith(self.project_root):
            filename = os.path.relpath(filename, self.project_root)

        return f"{filename}:{function_name}:{lineno}"

    def _is_pydantic_model(self, obj) -> bool:
        """Check if the object is a Pydantic model"""
        return hasattr(obj, "__fields__") or (
            hasattr(obj, "__class__") and hasattr(obj.__class__, "__fields__")
        )

    def _is_dataclass(self, obj) -> bool:
        """Check if the object is a dataclass"""
        return hasattr(obj, "__dataclass_fields__")

    def _is_custom_class(self, obj) -> bool:
        """Check if the object is a custom class instance"""
        if obj is None:
            return False

        # Treat non-basic-type objects as custom classes
        builtin_types = (str, int, float, bool, list, dict, tuple, set, bytes)
        if isinstance(obj, builtin_types):
            return False

        # Exclude modules, functions, methods, etc.
        if (
            inspect_module.ismodule(obj)
            or inspect_module.isfunction(obj)
            or inspect_module.ismethod(obj)
        ):
            return False

        return True

    def _get_type_annotation(self, obj) -> str:
        """Get type annotation from an object if possible"""
        try:
            # Check for type annotations in the calling frame
            frame = inspect_module.currentframe()
            if frame is None:
                return ""

            # Go up frames to find the actual caller
            annotation = ""
            for _ in range(10):
                frame = frame.f_back
                if frame is None:
                    break

                # Look at local variables
                for var_name, var_value in frame.f_locals.items():
                    if var_value is obj:
                        # Check function annotations
                        func = frame.f_code
                        if func.co_name in frame.f_globals:
                            function = frame.f_globals[func.co_name]
                            if hasattr(function, "__annotations__"):
                                if var_name in function.__annotations__:
                                    annotation = f"{var_name}: {function.__annotations__[var_name]}"
                                    break

                        # Check if it's possibly from a method parameter
                        if "self" in frame.f_locals:
                            self_obj = frame.f_locals["self"]
                            cls = self_obj.__class__
                            for attr_name in dir(cls):
                                method = getattr(cls, attr_name, None)
                                if (
                                    hasattr(method, "__annotations__")
                                    and var_name in method.__annotations__
                                ):
                                    annotation = f"{var_name}: {method.__annotations__[var_name]}"
                                    break

                        # If no annotation but we have the variable name
                        if not annotation:
                            annotation = var_name
                        break

                if annotation:
                    break
        except Exception:
            pass

        # typing.Any だった場合や型が見つからなかった場合は実際の型情報を使用
        if (annotation == "obj: typing.Any" or not annotation) and obj is not None:
            actual_type = type(obj).__name__
            module_name = type(obj).__module__
            if module_name != "builtins":
                actual_type = f"{module_name}.{actual_type}"
            return f"{actual_type}"  # "obj:" と "(inferred)" を削除

        return annotation

    def _format_value(self, value: Any, max_depth=3, current_depth=0) -> str:
        """Format values in a readable way"""
        if current_depth >= max_depth:
            return "..."

        if value is None:
            return "None"

        if isinstance(value, (str, int, float, bool)):
            return repr(value)

        # For collections of objects, we want to inspect each item
        if isinstance(value, (list, tuple)):
            if not value:
                return "[]" if isinstance(value, list) else "()"

            # For small collections, expand each item
            if len(value) <= 5:  # Reasonable limit for readability
                parts = []
                for i, item in enumerate(value):
                    # For custom classes, try to extract their attributes
                    if self._is_custom_class(item) and current_depth < max_depth - 1:
                        item_attrs = self._get_object_attributes(item)
                        # Format as a dict-like structure with class name
                        attr_parts = []
                        for attr_name, attr_value in item_attrs.items():
                            formatted_attr = self._format_value(
                                attr_value, max_depth, current_depth + 2
                            )
                            attr_parts.append(f"{attr_name}: {formatted_attr}")
                        parts.append(
                            f"{item.__class__.__name__}{{{', '.join(attr_parts)}}}"
                        )
                    else:
                        # Standard formatting for non-custom or at depth limit
                        formatted_item = self._format_value(
                            item, max_depth, current_depth + 1
                        )
                        parts.append(formatted_item)

                if isinstance(value, list):
                    return "[\n  " + ",\n  ".join(parts) + "\n]"
                else:
                    return "(\n  " + ",\n  ".join(parts) + "\n)"
            else:
                # For larger collections, summarize
                sample_count = min(3, len(value))
                summary = f"[{len(value)} items: "
                parts = []

                # Format first few items
                for i in range(sample_count):
                    item = value[i]
                    if self._is_custom_class(item):
                        parts.append(f"<{item.__class__.__name__}>")
                    else:
                        parts.append(
                            self._format_value(
                                item, max_depth=1, current_depth=current_depth + 1
                            )
                        )

                summary += ", ".join(parts)
                if sample_count < len(value):
                    summary += ", ..."
                summary += "]"
                return summary

        if self._is_custom_class(value):
            # If we're not at max depth, extract and format the object's attributes
            if current_depth < max_depth - 1:
                attributes = self._get_object_attributes(value)
                if attributes:
                    parts = []
                    for attr_name, attr_value in attributes.items():
                        formatted_v = self._format_value(
                            attr_value, max_depth, current_depth + 1
                        )
                        parts.append(f"{attr_name}: {formatted_v}")
                    return f"{value.__class__.__name__}{{{', '.join(parts)}}}"

            # Default case or at max depth
            return f"<{value.__class__.__name__} instance>"

        if isinstance(value, dict):
            if not value:
                return "{}"

            parts = []
            for k, v in value.items():
                formatted_v = self._format_value(v, max_depth, current_depth + 1)
                parts.append(f"{repr(k)}: {formatted_v}")

            return "{" + ", ".join(parts) + "}"

        # Other types
        return repr(value)

    def _get_object_attributes(self, obj: Any) -> Dict[str, Any]:
        """Get object attributes"""
        attributes = {}

        if self._is_pydantic_model(obj):
            # For Pydantic models
            try:
                # For new Pydantic v2
                if hasattr(obj, "model_dump"):
                    attributes = obj.model_dump()
                # For old Pydantic v1
                elif hasattr(obj, "dict"):
                    attributes = obj.dict()
                else:
                    # Fallback
                    for field_name in getattr(obj.__class__, "__fields__", {}).keys():
                        if hasattr(obj, field_name):
                            attributes[field_name] = getattr(obj, field_name)
            except Exception as e:
                attributes["__error__"] = f"Error accessing Pydantic model: {str(e)}"

        elif self._is_dataclass(obj):
            # For dataclasses
            import dataclasses

            if hasattr(dataclasses, "asdict"):
                try:
                    attributes = dataclasses.asdict(obj)
                except Exception as e:
                    for field in dataclasses.fields(obj):
                        attributes[field.name] = getattr(obj, field.name, None)

        else:
            # For regular classes
            # Include private attributes (starting with _)
            for attr_name in dir(obj):
                # Exclude magic methods and callables (methods)
                if not attr_name.startswith("__") and not callable(
                    getattr(obj, attr_name)
                ):
                    try:
                        attributes[attr_name] = getattr(obj, attr_name)
                    except Exception:
                        attributes[attr_name] = "<Error retrieving attribute>"

        return attributes

    def _get_object_type_name(self, obj: Any) -> str:
        """Get the type name of an object"""
        if obj is None:
            return "None"

        if hasattr(obj, "__class__"):
            # Get class name and module name
            class_name = obj.__class__.__name__
            module_name = obj.__class__.__module__

            # Skip module name for built-in types
            if module_name == "builtins":
                return class_name

            return f"{module_name}.{class_name}"

        return type(obj).__name__

    def _create_table(self, headers: List[str], rows: List[List[str]]) -> str:
        """Create an ASCII table with consistent width"""
        # Calculate the maximum width for each column
        col_widths = [len(h) for h in headers]

        # Initial pass to determine column widths based on content
        for row in rows:
            for i, cell in enumerate(row):
                first_line = cell.split("\n")[0]
                col_widths[i] = max(col_widths[i], len(first_line))

        # Calculate total width needed
        total_width_needed = sum(col_widths) + (3 * len(col_widths)) + 1

        # If total width is less than max_width, adjust to use consistent width
        target_width = self.max_width

        # If the total width is greater than max_width, adjust columns
        if total_width_needed > target_width:
            # 現在のコードと同様の調整ロジック
            available_width = target_width - (3 * len(col_widths)) - 1

            if len(col_widths) == 2:
                col_widths[0] = min(col_widths[0], available_width // 3)
                col_widths[1] = available_width - col_widths[0]
            elif len(col_widths) == 3:
                col_widths[0] = min(col_widths[0], available_width // 5)
                col_widths[1] = min(col_widths[1], available_width // 5)
                col_widths[2] = available_width - col_widths[0] - col_widths[1]
            else:
                even_width = available_width // len(col_widths)
                col_widths = [even_width] * len(col_widths)
        else:
            # 追加: 小さいテーブルでも一貫した幅にするための調整
            # 現在の合計幅と目標幅の差分
            width_diff = target_width - total_width_needed

            # 最後の列に余分な幅を割り当てる（通常は値の列）
            if len(col_widths) > 0:
                col_widths[-1] += width_diff

        # Create header row
        header_line = (
            "│ "
            + " │ ".join(h.ljust(col_widths[i]) for i, h in enumerate(headers))
            + " │"
        )
        separator = "├─" + "─┼─".join("─" * w for w in col_widths) + "─┤"
        top_border = "┌─" + "─┬─".join("─" * w for w in col_widths) + "─┐"
        bottom_border = "└─" + "─┴─".join("─" * w for w in col_widths) + "─┘"

        # Build the table
        table_lines = [top_border, header_line, separator]

        for row in rows:
            # Word-wrap content in cells
            wrapped_cells = []
            for i, cell_content in enumerate(row):
                # Split cell content by existing newlines
                cell_lines = cell_content.split("\n")
                wrapped_lines = []

                for line in cell_lines:
                    # Word-wrap the line
                    current_width = col_widths[i]

                    while len(line) > current_width:
                        # Find the last space within the width limit
                        space_pos = line[:current_width].rfind(" ")

                        if space_pos > 0:  # If there's a space to break at
                            wrapped_lines.append(line[:space_pos])
                            line = line[space_pos + 1 :]
                        else:  # No space to break at, forced break
                            wrapped_lines.append(line[:current_width])
                            line = line[current_width:]

                    wrapped_lines.append(line)  # Add the remainder

                wrapped_cells.append(wrapped_lines)

            # Find the maximum number of lines in any cell for this row
            max_lines = max(len(cell_lines) for cell_lines in wrapped_cells)

            # Process each line in the row
            for line_idx in range(max_lines):
                line_cells = []

                for i, cell_lines in enumerate(wrapped_cells):
                    if line_idx < len(cell_lines):
                        # This cell has this line
                        padding = col_widths[i] - len(cell_lines[line_idx])
                        line_cells.append(cell_lines[line_idx] + " " * padding)
                    else:
                        # This cell doesn't have this line
                        line_cells.append(" " * col_widths[i])

                table_lines.append("│ " + " │ ".join(line_cells) + " │")

        table_lines.append(bottom_border)
        return "\n".join(table_lines)

    def _create_header(self, title: str, width: int) -> str:
        """Create a header"""
        padding = max(0, (width - len(title) - 2)) // 2
        return (
            "┌"
            + "─" * (width - 2)
            + "┐\n"
            + "│"
            + " " * padding
            + title
            + " " * (width - len(title) - 2 - padding)
            + "│\n"
            + "└"
            + "─" * (width - 2)
            + "┘"
        )

    def inspect(
        self,
        obj: Any,
        max_depth=3,
        obj_index=None,
        total_objects=None,
        show_type_info=True,
    ):
        """Inspect the internal structure of an object and display it"""
        if obj is None:
            print("None")
            return

        # Get caller info early
        caller_info = self.get_caller_info()

        # Attempt to get type annotation or variable name
        type_info = ""
        if show_type_info:
            type_info = self._get_type_annotation(obj)

        # Get the type name of the object
        type_name = self._get_object_type_name(obj)

        # Create a combined header
        header_parts = [caller_info]

        # Add type info if available
        if type_info:
            header_parts.append(type_info)

        # Add index information if we're displaying multiple objects
        if obj_index is not None and total_objects is not None:
            header_parts.append(f"{obj_index}/{total_objects}")

        header_title = " - ".join(header_parts)

        # Log to standard logger only once
        if obj_index is None or obj_index == 1:
            self.logger.info(f"[Betterlog] {header_title}")

        # Handle collections specially - for lists of custom objects, consider expanding them
        if (
            isinstance(obj, (list, tuple))
            and len(obj) > 0
            and len(obj) <= 10
            and all(self._is_custom_class(item) for item in obj)
        ):
            # This is a list of custom objects, prepare to display all together
            all_tables = []
            table_width = self.max_width

            # Process each item
            for i, item in enumerate(obj):
                item_title = f"{header_title}[{i}]"
                attributes = self._get_object_attributes(item)

                # Table headers
                headers = ["Attribute", "Value"]

                # Prepare table rows
                rows = []
                for attr_name, attr_value in attributes.items():
                    attr_value_str = self._format_value(attr_value, max_depth)
                    rows.append([attr_name, attr_value_str])

                # Create table
                item_table = self._create_table(headers, rows)

                # Calculate width
                this_table_width = max(len(line) for line in item_table.split("\n"))
                table_width = max(table_width, this_table_width)

                # Keep track of tables
                all_tables.append((f"Item {i+1}/{len(obj)}", item_table))

            # Create a combined output
            combined_output = []

            # Add a single header for all items
            combined_header = self._create_header(header_title, table_width)
            combined_output.append(combined_header)

            # Add each table with a subheader
            for title, table in all_tables:
                # Add a simple item separator
                combined_output.append(f"\n--- {title} ---\n")
                combined_output.append(table)

            # Print the combined output
            print("\n".join(combined_output))

            # We've handled all items together, return early
            return

        # Get attributes for custom class objects
        elif self._is_custom_class(obj):
            attributes = self._get_object_attributes(obj)

            # Table headers
            headers = ["Attribute", "Value"]

            # Prepare table rows
            rows = []
            for attr_name, attr_value in attributes.items():
                attr_value_str = self._format_value(attr_value, max_depth)
                rows.append([attr_name, attr_value_str])

            # Create table
            table = self._create_table(headers, rows)

        else:
            # Simple display for basic types
            # Table headers
            headers = ["Value"]

            # Prepare table rows
            rows = [[self._format_value(obj, max_depth)]]

            # Create table
            table = self._create_table(headers, rows)

        # Calculate width
        table_width = max(len(line) for line in table.split("\n"))

        # Add header with caller info
        header = self._create_header(header_title, table_width)

        # Final output
        final_output = f"{header}\n{table}"
        print(final_output)

    def log(self, *objects, max_depth=3, show_type_info=True):
        """Log objects with the simplified interface"""
        if not objects:
            print("No objects to log")
            return

        # Process each object
        for i, obj in enumerate(objects):
            self.inspect(
                obj,
                max_depth=max_depth,
                obj_index=i + 1 if len(objects) > 1 else None,
                total_objects=len(objects) if len(objects) > 1 else None,
                show_type_info=show_type_info,
            )

    def _detect_project_root(self) -> Optional[str]:
        """
        Attempt to auto-detect project root by looking for .git directory
        Starting from the current file's directory and moving up
        """
        try:
            # Start from the directory of the call stack caller
            frame = inspect_module.currentframe()
            if frame is None:
                return None

            # Get the directory of the calling file
            caller_file = None
            for _ in range(10):  # Limit to prevent infinite loop
                if frame is None:
                    break
                caller_file = frame.f_code.co_filename
                # Skip frames within this module
                if not caller_file.endswith("betterlog.py"):
                    break
                frame = frame.f_back

            if caller_file is None:
                return None

            current_dir = os.path.dirname(os.path.abspath(caller_file))

            # Traverse up the directory tree looking for .git
            while current_dir and current_dir != os.path.dirname(current_dir):
                if os.path.exists(os.path.join(current_dir, ".git")):
                    return current_dir
                current_dir = os.path.dirname(current_dir)

            return None
        except Exception as e:
            # Fail gracefully if there's any error
            return None

    def set_project_root(self, root_path):
        """Set the project root path for relative paths"""
        self.project_root = root_path


# Create singleton instance
_betterlog = Betterlog()


# Module-level function (simplified interface)
def log(*objects, max_depth=3, show_type_info=True):
    """Log objects with the betterlog formatting"""
    _betterlog.log(*objects, max_depth=max_depth, show_type_info=show_type_info)


# For setting project root if needed
def set_project_root(root_path=None):
    """
    Set the project root path for relative paths
    If root_path is None, attempts to auto-detect using .git directory
    """
    if root_path is None:
        # Force re-detection
        _betterlog.project_root = None
        _betterlog.project_root = _betterlog._detect_project_root()
        return _betterlog.project_root
    else:
        _betterlog.set_project_root(root_path)
        return root_path
