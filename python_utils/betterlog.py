import inspect as inspect_module
import os
from typing import Any, Dict, List, Optional


class Betterlog:
    """A simple utility to inspect and display internal structure of Python objects in a clean format"""

    def __init__(self, name=None, project_root=None, use_colors=True):
        """Initialize the inspector"""
        self.name = name or "betterlog"
        self.max_width = 120  # Default width
        self.project_root = project_root  # Store project root for relative paths
        self.use_colors = use_colors  # 色を使用するかどうかの設定

        # 色コードの定義 - シンプルに単色のみを使用
        self.color_code = "\033[32m"  # 緑色
        self.reset_code = "\033[0m"  # リセット

        # 色辞書は他のメソッドとの互換性のために空にしておく
        self.colors = {}

        # Auto-detect project root if not specified
        if self.project_root is None:
            self.project_root = self._detect_project_root()

    def _apply_color(self, text):
        """色をテキストに適用（単一色）"""
        if not self.use_colors:
            return text
        return f"{self.color_code}{text}{self.reset_code}"

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

        # 型情報を取得する
        if obj is not None:
            actual_type = type(obj).__name__
            module_name = type(obj).__module__
            if module_name != "builtins":
                actual_type = f"{module_name}.{actual_type}"

            # 変数名と型情報の両方がある場合
            if annotation and ":" not in annotation:  # 既に型情報が含まれていない場合
                return f"{annotation}: {actual_type}"
            elif not annotation:  # 変数名がない場合は型情報のみ
                return actual_type

        return annotation

    def _format_value(self, value: Any, max_depth=3, current_depth=0) -> str:
        """Format values in a readable way"""
        if current_depth >= max_depth:
            return self._apply_color("...")

        if value is None:
            return self._apply_color("None")

        if isinstance(value, (str, int, float, bool)):
            return self._apply_color(repr(value))

        # For collections of objects, we want to inspect each item
        if isinstance(value, (list, tuple)):
            if not value:
                return self._apply_color("[]" if isinstance(value, list) else "()")

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
                            attr_parts.append(
                                f"{self._apply_color(attr_name)}: {formatted_attr}"
                            )
                        parts.append(
                            f"{self._apply_color(item.__class__.__name__)}{self._apply_color('{')}{', '.join(attr_parts)}{self._apply_color('}')}"
                        )
                    else:
                        # Standard formatting for non-custom or at depth limit
                        formatted_item = self._format_value(
                            item, max_depth, current_depth + 1
                        )
                        parts.append(formatted_item)

                if isinstance(value, list):
                    return (
                        self._apply_color("[")
                        + self._apply_color(", ").join(parts)
                        + self._apply_color("]")
                    )
                else:
                    return (
                        self._apply_color("(")
                        + self._apply_color(", ").join(parts)
                        + self._apply_color(")")
                    )
            else:
                # For larger collections, summarize
                sample_count = min(3, len(value))
                summary = self._apply_color(f"[{len(value)} items: ")
                parts = []

                # Format first few items
                for i in range(sample_count):
                    item = value[i]
                    if self._is_custom_class(item):
                        parts.append(self._apply_color(f"<{item.__class__.__name__}>"))
                    else:
                        parts.append(
                            self._format_value(
                                item, max_depth=1, current_depth=current_depth + 1
                            )
                        )

                summary += self._apply_color(", ").join(parts)
                if sample_count < len(value):
                    summary += self._apply_color(", ...")
                summary += self._apply_color("]")
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
                        parts.append(f"{self._apply_color(attr_name)}: {formatted_v}")
                    return f"{self._apply_color(value.__class__.__name__)}{self._apply_color('{')}{self._apply_color(', ').join(parts)}{self._apply_color('}')}"

            # Default case or at max depth
            return self._apply_color(f"<{value.__class__.__name__} instance>")

        if isinstance(value, dict):
            if not value:
                return self._apply_color("{}")

            parts = []
            for k, v in value.items():
                formatted_v = self._format_value(v, max_depth, current_depth + 1)
                parts.append(f"{self._apply_color(repr(k))}: {formatted_v}")

            return (
                self._apply_color("{")
                + self._apply_color(", ").join(parts)
                + self._apply_color("}")
            )

        # Other types
        return self._apply_color(repr(value))

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

    def _create_simple_output(
        self, headers: List[str], rows: List[List[str]], type_name=None
    ) -> str:
        """Create a simple, colored, and easily copyable key-value format output"""
        output_lines = []

        # オブジェクト型情報を表示（存在する場合）
        if type_name:
            output_lines.append(self._apply_color(f"# Object Type: {type_name}"))

        # ヘッダーをシンプルなコメントとして表示（色付き）
        header_text = " | ".join(headers)
        output_lines.append(self._apply_color(f"# {header_text}"))
        output_lines.append(self._apply_color("# " + "-" * len(header_text)))

        # 内容を処理（区切り文字なし、シンプルな形式、色付き）
        for row in rows:
            # 複数列の場合（通常はkey-value形式）
            if len(row) >= 2:
                key = row[0]
                value = row[1]
                # Key: Valueの形式（キーを色付け）
                output_lines.append(f"{self._apply_color(key)}: {value}")
            # 単一列の場合（単純な値）
            elif len(row) == 1:
                output_lines.append(f"{row[0]}")

        return "\n".join(output_lines)

    def inspect(
        self,
        obj: Any,
        max_depth=3,
        obj_index=None,
        total_objects=None,
        show_type_info=True,
    ):
        """Inspect the internal structure of an object and display it in a simple, colored format"""
        if obj is None:
            if self.use_colors:
                print(self._apply_color("None"))
            else:
                print("None")
            return

        # 呼び出し情報を取得
        caller_info = self.get_caller_info()

        # オブジェクトの型名を取得
        type_name = self._get_object_type_name(obj)

        # ヘッダー情報の作成
        header_parts = [caller_info]

        # 複数オブジェクトの場合、インデックス情報を追加
        if obj_index is not None and total_objects is not None:
            header_parts.append(f"{obj_index}/{total_objects}")

        header_title = " - ".join(header_parts)

        # カスタムオブジェクトのリストの特別な処理
        if (
            isinstance(obj, (list, tuple))
            and len(obj) > 0
            and len(obj) <= 10
            and all(self._is_custom_class(item) for item in obj)
        ):
            # すべての出力を蓄積
            all_outputs = []

            # ヘッダーを追加（色付き）
            all_outputs.append(self._apply_color(f"# {header_title}"))
            all_outputs.append(self._apply_color("# " + "=" * len(header_title)))

            # 各アイテムを処理
            for i, item in enumerate(obj):
                item_title = f"Item {i+1}/{len(obj)} ({item.__class__.__name__})"
                all_outputs.append("")
                all_outputs.append(self._apply_color(f"# --- {item_title} ---"))

                # アイテムの属性を取得
                attributes = self._get_object_attributes(item)

                # 行の準備
                rows = []
                for attr_name, attr_value in attributes.items():
                    attr_value_str = self._format_value(attr_value, max_depth)
                    rows.append([attr_name, attr_value_str])

                # シンプルな出力形式を使用
                item_output = self._create_simple_output(
                    ["Attribute", "Value"], rows, item.__class__.__name__
                )
                all_outputs.append(item_output)

            # 出力を表示
            print("\n".join(all_outputs))
            return

        # カスタムクラスオブジェクトの場合
        elif self._is_custom_class(obj):
            attributes = self._get_object_attributes(obj)

            # ヘッダー
            headers = ["Attribute", "Value"]

            # 行の準備
            rows = []
            for attr_name, attr_value in attributes.items():
                attr_value_str = self._format_value(attr_value, max_depth)
                rows.append([attr_name, attr_value_str])

            # シンプル形式の出力を作成
            output = self._create_simple_output(headers, rows, type_name)

        # 基本型の場合
        else:
            # ヘッダー
            headers = [f"Value ({type_name})"]

            # 行の準備
            rows = [[self._format_value(obj, max_depth)]]

            # シンプル形式の出力を作成
            output = self._create_simple_output(headers, rows)

        # 呼び出し情報をヘッダーとして表示
        final_output = [
            self._apply_color(f"# {header_title}"),
            self._apply_color("# " + "=" * len(header_title)),
            output,
        ]

        # 出力を表示
        print("\n".join(final_output))

    def log(self, *objects, max_depth=3, show_type_info=True):
        """Log objects with the simplified interface"""
        if not objects:
            print("No objects to log")
            return

        # 各オブジェクトを処理
        for i, obj in enumerate(objects):
            self.inspect(
                obj,
                max_depth=max_depth,
                obj_index=i + 1 if len(objects) > 1 else None,
                total_objects=len(objects) if len(objects) > 1 else None,
                show_type_info=show_type_info,
            )


# Create singleton instance
_betterlog = Betterlog()


# Module-level function (simplified interface)
def log(*objects, max_depth=3, show_type_info=True):
    """Log objects with the betterlog formatting"""
    _betterlog.log(*objects, max_depth=max_depth, show_type_info=show_type_info)
