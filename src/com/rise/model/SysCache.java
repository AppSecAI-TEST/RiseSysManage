package com.rise.model;

import java.util.Date;

public class SysCache {
    private Integer cacheId;

    private String cacheName;

    private String cacheDesc;
    
    private String cacheParam;

    private Date cacheDate;

    private String state;

    public Integer getCacheId() {
        return cacheId;
    }

    public void setCacheId(Integer cacheId) {
        this.cacheId = cacheId;
    }

    public String getCacheName() {
        return cacheName;
    }

    public void setCacheName(String cacheName) {
        this.cacheName = cacheName == null ? null : cacheName.trim();
    }

    public String getCacheDesc() {
        return cacheDesc;
    }

    public void setCacheDesc(String cacheDesc) {
        this.cacheDesc = cacheDesc == null ? null : cacheDesc.trim();
    }

    public String getCacheParam() {
		return cacheParam;
	}

	public void setCacheParam(String cacheParam) {
		this.cacheParam = cacheParam;
	}

	public Date getCacheDate() {
        return cacheDate;
    }

    public void setCacheDate(Date cacheDate) {
        this.cacheDate = cacheDate;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state == null ? null : state.trim();
    }
}