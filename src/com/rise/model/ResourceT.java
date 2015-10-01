package com.rise.model;

import java.util.Date;

public class ResourceT {
    private Integer resourceId;

    private String fieldId;

    private String fieldName;

    private String tableName;

    private String widgetType;

    private String widgetName;

    private String expRule;

    private String widgetStyle;

    private Integer orderes;

    private String dataSourceTable;

    private String dataSourceField;

    private String dataSourceSql;

    private Integer funcNodeId;

    private String state;

    private Date createDate;

    private Integer handlerId;

    public Integer getResourceId() {
        return resourceId;
    }

    public void setResourceId(Integer resourceId) {
        this.resourceId = resourceId;
    }

    public String getFieldId() {
        return fieldId;
    }

    public void setFieldId(String fieldId) {
        this.fieldId = fieldId == null ? null : fieldId.trim();
    }

    public String getFieldName() {
        return fieldName;
    }

    public void setFieldName(String fieldName) {
        this.fieldName = fieldName == null ? null : fieldName.trim();
    }

    public String getTableName() {
        return tableName;
    }

    public void setTableName(String tableName) {
        this.tableName = tableName == null ? null : tableName.trim();
    }

    public String getWidgetType() {
        return widgetType;
    }

    public void setWidgetType(String widgetType) {
        this.widgetType = widgetType == null ? null : widgetType.trim();
    }

    public String getWidgetName() {
        return widgetName;
    }

    public void setWidgetName(String widgetName) {
        this.widgetName = widgetName == null ? null : widgetName.trim();
    }

    public String getExpRule() {
        return expRule;
    }

    public void setExpRule(String expRule) {
        this.expRule = expRule == null ? null : expRule.trim();
    }

    public String getWidgetStyle() {
        return widgetStyle;
    }

    public void setWidgetStyle(String widgetStyle) {
        this.widgetStyle = widgetStyle == null ? null : widgetStyle.trim();
    }

    public Integer getOrderes() {
        return orderes;
    }

    public void setOrderes(Integer orderes) {
        this.orderes = orderes;
    }

    public String getDataSourceTable() {
        return dataSourceTable;
    }

    public void setDataSourceTable(String dataSourceTable) {
        this.dataSourceTable = dataSourceTable == null ? null : dataSourceTable.trim();
    }

    public String getDataSourceField() {
        return dataSourceField;
    }

    public void setDataSourceField(String dataSourceField) {
        this.dataSourceField = dataSourceField == null ? null : dataSourceField.trim();
    }

    public String getDataSourceSql() {
        return dataSourceSql;
    }

    public void setDataSourceSql(String dataSourceSql) {
        this.dataSourceSql = dataSourceSql == null ? null : dataSourceSql.trim();
    }

    public Integer getFuncNodeId() {
        return funcNodeId;
    }

    public void setFuncNodeId(Integer funcNodeId) {
        this.funcNodeId = funcNodeId;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state == null ? null : state.trim();
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public Integer getHandlerId() {
        return handlerId;
    }

    public void setHandlerId(Integer handlerId) {
        this.handlerId = handlerId;
    }
}