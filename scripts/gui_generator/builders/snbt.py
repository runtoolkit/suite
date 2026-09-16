"""Emit item replace / clear commands with object-style components."""

from __future__ import annotations

from models.components import ItemComponents


def item_id(item: str) -> str:
    """Ensure the item string has a namespace (defaulting to 'minecraft:')."""
    return item if ":" in item else f"minecraft:{item}"


def item_replace_command(selector: str, slot: int, item: str, components: ItemComponents) -> str:
    """Generate a command to replace an item in an entity's container slot."""
    suffix = components.to_snbt_suffix()
    return f"item replace entity {selector} container.{slot} with {item_id(item)}{suffix}"


def clear_detect_command(item: str, action: str = "") -> str:
    """Generate a clear command to detect items marked with custom GUI data."""
    # Doubled curly braces `{{` and `}}` escape them inside the f-string
    return f'clear @s {item_id(item)}[custom_data={{guigen:{{}}}}] 64'
