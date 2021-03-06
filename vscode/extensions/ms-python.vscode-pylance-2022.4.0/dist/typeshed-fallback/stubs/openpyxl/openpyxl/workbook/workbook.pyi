from typing import Any

INTEGER_TYPES: Any

class Workbook:
    template: bool
    path: str
    defined_names: Any
    properties: Any
    security: Any
    shared_strings: Any
    loaded_theme: Any
    vba_archive: Any
    is_template: bool
    code_name: Any
    encoding: str
    iso_dates: Any
    rels: Any
    calculation: Any
    views: Any
    def __init__(self, write_only: bool = ..., iso_dates: bool = ...) -> None: ...
    @property
    def epoch(self): ...
    @epoch.setter
    def epoch(self, value) -> None: ...
    @property
    def read_only(self): ...
    @property
    def data_only(self): ...
    @property
    def write_only(self): ...
    @property
    def excel_base_date(self): ...
    @property
    def active(self): ...
    @active.setter
    def active(self, value) -> None: ...
    def create_sheet(self, title: Any | None = ..., index: Any | None = ...): ...
    def move_sheet(self, sheet, offset: int = ...) -> None: ...
    def remove(self, worksheet) -> None: ...
    def remove_sheet(self, worksheet) -> None: ...
    def create_chartsheet(self, title: Any | None = ..., index: Any | None = ...): ...
    def get_sheet_by_name(self, name): ...
    def __contains__(self, key): ...
    def index(self, worksheet): ...
    def get_index(self, worksheet): ...
    def __getitem__(self, key): ...
    def __delitem__(self, key) -> None: ...
    def __iter__(self): ...
    def get_sheet_names(self): ...
    @property
    def worksheets(self): ...
    @property
    def chartsheets(self): ...
    @property
    def sheetnames(self): ...
    def create_named_range(self, name, worksheet: Any | None = ..., value: Any | None = ..., scope: Any | None = ...) -> None: ...
    def add_named_style(self, style) -> None: ...
    @property
    def named_styles(self): ...
    def get_named_ranges(self): ...
    def add_named_range(self, named_range) -> None: ...
    def get_named_range(self, name): ...
    def remove_named_range(self, named_range) -> None: ...
    @property
    def mime_type(self): ...
    def save(self, filename) -> None: ...
    @property
    def style_names(self): ...
    def copy_worksheet(self, from_worksheet): ...
    def close(self) -> None: ...
