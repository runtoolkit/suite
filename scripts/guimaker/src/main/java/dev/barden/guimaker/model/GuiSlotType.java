package dev.barden.guimaker.model;

public enum GuiSlotType {
    SIMPLE_BUTTON,
    ITEM_HOLDER,
    TOGGLE_BUTTON,
    DATA_DRIVEN_BUTTON,
    DATA_DRIVEN_PAGE_CREATOR;

    public static GuiSlotType fromString(String value) {
        return switch (value.toLowerCase()) {
            case "holder", "item_holder" -> ITEM_HOLDER;
            case "toggle", "toggle_button" -> TOGGLE_BUTTON;
            case "data_button", "data_driven_button" -> DATA_DRIVEN_BUTTON;
            case "data_page", "data_driven_page_creator", "page_creator" -> DATA_DRIVEN_PAGE_CREATOR;
            default -> SIMPLE_BUTTON;
        };
    }

    public String serializedName() {
        return switch (this) {
            case SIMPLE_BUTTON -> "simple_button";
            case ITEM_HOLDER -> "holder";
            case TOGGLE_BUTTON -> "toggle_button";
            case DATA_DRIVEN_BUTTON -> "data_driven_button";
            case DATA_DRIVEN_PAGE_CREATOR -> "data_driven_page_creator";
        };
    }
}
