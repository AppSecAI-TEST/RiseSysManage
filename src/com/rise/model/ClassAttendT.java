package com.rise.model;

import java.util.Date;
import java.util.List;

public class ClassAttendT {
    private Integer classAttendId;

    private Integer classInstId;

    private Integer schoolId;

    private Date attendDate;

    private String hourRange;

    private Integer hours;

    private Integer roomId;

    private Integer lateNum;

    private Integer truantNum;

    private Integer leaveNum;

    private Integer attendNum;

    private Integer realNum;
    
    private String isFirst;

    private String attendRate;

    private String teacherIds;

    private Date schooltime;
    
    private Integer handlerId;

    private Date createDate;
    
    private Integer baseHours;
    
	private RoomT roomT;
	
	private TimeT timeTObj;
	
	private String teacherNames;
	
	private String attendDateWeek;
	
	private StaffT handlerObj;
	
	private List<TeacherAttendT> teacherAttendList;
	
	private List<StudentAttendT> studentAttendList;

    public Integer getClassAttendId() {
        return classAttendId;
    }

    public void setClassAttendId(Integer classAttendId) {
        this.classAttendId = classAttendId;
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

    public Date getAttendDate() {
        return attendDate;
    }

    public void setAttendDate(Date attendDate) {
        this.attendDate = attendDate;
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
        this.attendRate = attendRate;
    }
    
    public String getIsFirst() {
		return isFirst;
	}

	public void setIsFirst(String isFirst) {
		this.isFirst = isFirst;
	}

	public String getTeacherIds() {
        return teacherIds;
    }

    public void setTeacherIds(String teacherIds) {
        this.teacherIds = teacherIds == null ? null : teacherIds.trim();
    }
    
    public Date getSchooltime() {
		return schooltime;
	}

	public void setSchooltime(Date schooltime) {
		this.schooltime = schooltime;
	}

	public Integer getHandlerId() {
        return handlerId;
    }

    public void setHandlerId(Integer handlerId) {
        this.handlerId = handlerId;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }
    
	public Integer getBaseHours() {
		return baseHours;
	}

	public void setBaseHours(Integer baseHours) {
		this.baseHours = baseHours;
	}

	public RoomT getRoomT() {
		return roomT;
	}

	public void setRoomT(RoomT roomT) {
		this.roomT = roomT;
	}

	public TimeT getTimeTObj() {
		return timeTObj;
	}

	public void setTimeTObj(TimeT timeTObj) {
		this.timeTObj = timeTObj;
	}

	public String getTeacherNames() {
		return teacherNames;
	}

	public void setTeacherNames(String teacherNames) {
		this.teacherNames = teacherNames;
	}
	
	public String getAttendDateWeek() {
		return attendDateWeek;
	}

	public void setAttendDateWeek(String attendDateWeek) {
		this.attendDateWeek = attendDateWeek;
	}

	public StaffT getHandlerObj() {
		return handlerObj;
	}

	public void setHandlerObj(StaffT handlerObj) {
		this.handlerObj = handlerObj;
	}

	public List<TeacherAttendT> getTeacherAttendList() {
		return teacherAttendList;
	}

	public void setTeacherAttendList(List<TeacherAttendT> teacherAttendList) {
		this.teacherAttendList = teacherAttendList;
	}

	public List<StudentAttendT> getStudentAttendList() {
		return studentAttendList;
	}

	public void setStudentAttendList(List<StudentAttendT> studentAttendList) {
		this.studentAttendList = studentAttendList;
	}
	
}