package com.dharmendra.Springboottutorial.service;

import java.util.List;

import com.dharmendra.Springboottutorial.entity.Department;

public interface DepartmentService {

	public Department saveDepartment(Department department);

	public List<Department> getDepartmentList();

	public Department getDepartmentById(Long departmentId);

	public void deleteDepartmentById(Long departmentId);

	public Department updateDepartment(Long departmentId, Department department);

}
