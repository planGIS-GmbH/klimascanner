import re
from packaging.version import Version, InvalidVersion
from packaging.specifiers import SpecifierSet

_HAS_OP = re.compile(r"(==|!=|>=|<=|>|<|~=)")

def is_version_satisfied(installed_ver: str, operator: str | None, required_ver: str | None) -> bool:
    if operator is None and required_ver is None:
        return True

    try:
        inst = Version(installed_ver)
    except InvalidVersion:
        return False

    if operator and required_ver is None and _HAS_OP.search(operator):
        try:
            return inst in SpecifierSet(operator.strip())
        except Exception:
            return False

    if operator is None or required_ver is None:
        return True

    if operator == "=":
        operator = "=="

    try:
        req = Version(required_ver)
    except InvalidVersion:
        return False

    if operator == "==":
        return inst == req
    elif operator == "!=":
        return inst != req
    elif operator == ">=":
        return inst >= req
    elif operator == "<=":
        return inst <= req
    elif operator == ">":
        return inst > req
    elif operator == "<":
        return inst < req
    elif operator == "~=":
        try:
            return inst in SpecifierSet(f"{operator}{required_ver}")
        except Exception:
            return False
    else:
        return False
