package com.rise.model;

import java.util.Date;
import java.util.List;

public class SchooltimeInstT {
    private Integer schooltimeInstId;

    private Integer classInstId;

    private String className;

    private Integer roomId;

    private Integer schoolId;

    private Integer lessionHours;

    private String hourRange;
    
    private String hourRangeName;

    private String weekTime;

    private String weekSeq;

    private Integer teacherId;

    private String teacherName;

    private String teacherType;

    private Date schooltime;

    private String state;

    private Date createDate;
    
    private Integer planClassTime;
    
    private Integer realClassTime;
    
	private RoomT roomT;
	
	private SchoolT schoolT;
	
	private ClassInstT classInstT;
	
	private List<TeacherLicenseT> classLicenseList;

    public Integer getSchooltimeInstId() {
        return schooltimeInstId;
    }

    public void setSchooltimeInstId(Integer schooltimeInstId) {
        this.schooltimeInstId = schooltimeInstId;
    }

    public Integer getClassInstId() {
        return classInstId;
    }

    public void setClassInstId(Integer classInstId) {
        this.classInstId = classInstId;
    }

    public String getClassName() {
        return className;
    }

    public void setClassName(String className) {
        this.className = className == null ? null : className.trim();
    }

    public Integer getRoomId() {
        return roomId;
    }

    public void setRoomId(Integer roomId) {
        this.roomId = roomId;
    }

    public Integer getSchoolId() {
        return schoolId;
    }

    public void setSchoolId(Integer schoolId) {
        this.schoolId = schoolId;
    }

    public Integer getLessionHours() {
        return lessionHours;
    }

    public void setLessionHours(Integer lessionHours) {
        this.lessionHours = lessionHours;
    }

    public String getHourRangeName() {
		return hourRangeName;
	}

	public void setHourRangeName(String hourRangeName) {
		this.hourRangeName = hourRangeName;
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

    public String getWeekSeq() {
        return weekSeq;
    }

    public void setWeekSeq(String weekSeq) {
        this.weekSeq = weekSeq == null ? null : weekSeq.trim();
    }

    public Integer getTeacherId() {
        return teacherId;
    }

    public void setTeacherId(Integer teacherId) {
        this.teacherId = teacherId;
    }

    public String getTeacherName() {
        return teacherName;
    }

    public void setTeacherName(String teacherName) {
        this.teacherName = teacherName == null ? null : teacherName.trim();
    }

    public String getTeacherType() {
        return teacherType;
    }

    public void setTeacherType(String teacherType) {
        this.teacherType = teacherType == null ? null : teacherType.trim();
    }

    public Date getSchooltime() {
        return schooltime;
    }

    public void setSchooltime(Date schooltime) {
        this.schooltime = schooltime;
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

	public Integer getPlanClassTime() {
		return planClassTime;
	}

	public void setPlanClassTime(Integer planClassTime) {
		this.planClassTime = planClassTime;
	}
	
	public Integer getRealClassTime() {
		return realClassTime;
	}

	public void setRealClassTime(Integer realClassTime) {
		this.realClassTime = realClassTime;
	}

	public RoomT getRoomT() {
		return roomT;
	}

	public void setRoomT(RoomT roomT) {
		this.roomT = roomT;
	}

	public SchoolT getSchoolT() {
		return schoolT;
	}

	public void setSchoolT(SchoolT schoolT) {
		this.schoolT = schoolT;
	}

	public ClassInstT getClassInstT() {
		return classInstT;
	}

	public void setClassInstT(ClassInstT classInstT) {
		this.classInstT = classInstT;
	}

	public List<TeacherLicenseT> getClassLicenseList() {
		return classLicenseList;
	}

	public void setClassLicenseList(List<TeacherLicenseT> classLicenseList) {
		this.classLicenseList = classLicenseList;
	}
    
}