package com.rise.model;

import java.util.Date;
import java.util.List;

public class ShortClassAttendT {
    private Integer shortClassAttendId;

    private Integer shortClassInstId;
    
    private Integer shortSchooltimeId;

    private Integer schoolId;

    private Date attendDate;

    private Date schooltime;

    private String hourRange;

    private Integer hours;

    private Integer roomId;

    private Integer lateNum;

    private Integer truantNum;

    private Integer leaveNum;

    private Integer attendNum;

    private Integer realNum;

    private String attendRate;

    private String teacherIds;

    private Integer handerId;

    private Date createDate;
    
    private RoomT roomT;
    
	private ParaConfig hourRangeObj;
	
	private String teacherNames;
	
	private StaffT handlerObj;
	
	private List<ShortTeacherAttendT> teacherAttendList;
	
	private List<ShortStudentAttendT> studentAttendList;

    public Integer getShortClassAttendId() {
        return shortClassAttendId;
    }

    public void setShortClassAttendId(Integer shortClassAttendId) {
        this.shortClassAttendId = shortClassAttendId;
    }

    public Integer getShortClassInstId() {
        return shortClassInstId;
    }

    public void setShortClassInstId(Integer shortClassInstId) {
        this.shortClassInstId = shortClassInstId;
    }
    
    public Integer getShortSchooltimeId() {
		return shortSchooltimeId;
	}

	public void setShortSchooltimeId(Integer shortSchooltimeId) {
		this.shortSchooltimeId = shortSchooltimeId;
	}

	public Integer getSchoolId() {
        return schoolId;
    }

    public void setSchoolId(Integer schoolId) {
        this.schoolId = schoolId;
    }

    public Date getAttendDate() {
        return attendDate;
    }

    public void setAttendDate(Date attendDate) {
        this.attendDate = attendDate;
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

    public Integer getHours() {
        return hours;
    }

    public void setHours(Integer hours) {
        this.hours = hours;
    }

    public Integer getRoomId() {
        return roomId;
    }

    public void setRoomId(Integer roomId) {
        this.roomId = roomId;
    }

    public Integer getLateNum() {
        return lateNum;
    }

    public void setLateNum(Integer lateNum) {
        this.lateNum = lateNum;
    }

    public Integer getTruantNum() {
        return truantNum;
    }

    public void setTruantNum(Integer truantNum) {
        this.truantNum = truantNum;
    }

    public Integer getLeaveNum() {
        return leaveNum;
    }

    public void setLeaveNum(Integer leaveNum) {
        this.leaveNum = leaveNum;
    }

    public Integer getAttendNum() {
        return attendNum;
    }

    public void setAttendNum(Integer attendNum) {
        this.attendNum = attendNum;
    }

    public Integer getRealNum() {
        return realNum;
    }

    public void setRealNum(Integer realNum) {
        this.realNum = realNum;
    }

    public String getAttendRate() {
        return attendRate;
    }

    public void setAttendRate(String attendRate) {
        this.attendRate = attendRate == null ? null : attendRate.trim();
    }

    public String getTeacherIds() {
        return teacherIds;
    }

    public void setTeacherIds(String teacherIds) {
        this.teacherIds = teacherIds == null ? null : teacherIds.trim();
    }

    public Integer getHanderId() {
        return handerId;
    }

    public void setHanderId(Integer handerId) {
        this.handerId = handerId;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
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

	public String getTeacherNames() {
		return teacherNames;
	}

	public void setTeacherNames(String teacherNames) {
		this.teacherNames = teacherNames;
	}

	public StaffT getHandlerObj() {
		return handlerObj;
	}

	public void setHandlerObj(StaffT handlerObj) {
		this.handlerObj = handlerObj;
	}

	public List<ShortTeacherAttendT> getTeacherAttendList() {
		return teacherAttendList;
	}

	public void setTeacherAttendList(List<ShortTeacherAttendT> teacherAttendList) {
		this.teacherAttendList = teacherAttendList;
	}

	public List<ShortStudentAttendT> getStudentAttendList() {
		return studentAttendList;
	}

	public void setStudentAttendList(List<ShortStudentAttendT> studentAttendList) {
		this.studentAttendList = studentAttendList;
	}
    
}