package com.example.nnzcrawling.util.converter;

import javax.persistence.AttributeConverter;
import javax.persistence.Converter;

@Converter
public class ShowConverter implements AttributeConverter<String, String> {

    @Override
    public String convertToDatabaseColumn(String attribute) {
        if (attribute == null) return "";
        return attribute;
    }

    @Override
    public String convertToEntityAttribute(String dbData) {
        return dbData;
    }
}
