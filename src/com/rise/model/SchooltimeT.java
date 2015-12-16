package com.rise.model;

import java.util.Date;
import java.util.List;

public class SchooltimeT {
    private Integer schooltimeId;

    private Integer classInstId;

    private Integer schoolId;

    private Integer roomId;

    private String hourRange;

    private String weekTime;

    private Integer lessionHours;

    private String state;

    private Date createDate;

    private Integer handlerId;
    
    private String hourRangeName;
    
    private String roomName;
    
    private RoomT roomT;
    
	private List<ClassTeacherT> classTeacherList;

    public Integer getSchooltimeId() {
        return schooltimeId;
    }

    public void setSchooltimeId(Integer schooltimeId) {
        this.schooltimeId = schooltimeId;
    }

    public Integer getClassInstId() {
        return classInstId;
    }

    public void setClassInstId(Integer classInstId) {
        this.classInstId = classInstId;
    }

    public Integer getSchoolId() {
        return schoolId;
    }

    public void setSchoolId(Integer schoolId) {
        this.schoolId = schoolId;
    }

    public Integer getRoomId() {
        return roomId;
    }

    public void setRoomId(Integer roomId) {
        this.roomId = roomId;
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

    public Integer getHandlerId() {
        return handlerId;
    }

    public void setHandlerId(Integer handlerId) {
        this.handlerId = handlerId;
    }
    
	public String getHourRangeName() {
		return hourRangeName;
	}

	public void setHourRangeName(String hourRangeName) {
		this.hourRangeName = hourRangeName;
	}

	public String getRoomName() {
		return roomName;
	}

	public void setRoomName(String roomName) {
		this.roomName = roomName;
	}
	
	public RoomT getRoomT() {
		return roomT;
	}

	public void setRoomT(RoomT roomT) {
		this.roomT = roomT;
	}

	public List<ClassTeacherT> getClassTeacherList() {
		return classTeacherList;
	}

	public void setClassTeacherList(List<ClassTeacherT> classTeacherList) {
		this.classTeacherList = classTeacherList;
	}
    
}