package com.rise.model;

import java.util.Date;
import java.util.List;

public class ShortSchooltimeT {
    private Integer shortSchooltimeId;

    private Integer shortClassInstId;

    private Integer roomId;

    private Date schooltime;

    private String hourRange;

    private String weekTime;

    private Integer lessionHours;

    private String state;

    private Date createDate;

    private Date stateDate;

    private Integer handlerId;
    
    private RoomT roomT;
    
	private ParaConfig hourRangeObj;
	
	private List<ShortClassTeacherT> classTeacherList;

    public Integer getShortSchooltimeId() {
        return shortSchooltimeId;
    }

    public void setShortSchooltimeId(Integer shortSchooltimeId) {
        this.shortSchooltimeId = shortSchooltimeId;
    }

    public Integer getShortClassInstId() {
        return shortClassInstId;
    }

    public void setShortClassInstId(Integer shortClassInstId) {
        this.shortClassInstId = shortClassInstId;
    }

    public Integer getRoomId() {
        return roomId;
    }

    public void setRoomId(Integer roomId) {
        this.roomId = roomId;
    }

    public Date getSchooltime() {
        return schooltime;
    }

    public void setSchooltime(Date schooltime) {
        this.schooltime = schooltime;
    }

    public String getHourRange() {
        return hourRange;
    }

    public void setHourRange(String hourRange) {
        this.hourRange = hourRange == null ? null : hourRange.trim();
    }

    public String getWeekTime() {
        return weekTime;
    }

    public void setWeekTime(String weekTime) {
        this.weekTime = weekTime == null ? null : weekTime.trim();
    }

    public Integer getLessionHours() {
        return lessionHours;
    }

    public void setLessionHours(Integer lessionHours) {
        this.lessionHours = lessionHours;
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

    public Date getStateDate() {
        return stateDate;
    }

    public void setStateDate(Date stateDate) {
        this.stateDate = stateDate;
    }

    public Integer getHandlerId() {
        return handlerId;
    }

    public void setHandlerId(Integer handlerId) {
        this.handlerId = handlerId;
    }

	public RoomT getRoomT() {
		return roomT;
	}

	public void setRoomT(RoomT roomT) {
		this.roomT = roomT;
	}

	public ParaConfig getHourRangeObj() {
		return hourRangeObj;
	}

	public void setHourRangeObj(ParaConfig hourRangeObj) {
		this.hourRangeObj = hourRangeObj;
	}

	public List<ShortClassTeacherT> getClassTeacherList() {
		return classTeacherList;
	}

	public void setClassTeacherList(List<ShortClassTeacherT> classTeacherList) {
		this.classTeacherList = classTeacherList;
	}

}