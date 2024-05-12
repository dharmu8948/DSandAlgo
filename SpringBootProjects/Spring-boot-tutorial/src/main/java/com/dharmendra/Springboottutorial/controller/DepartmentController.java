package com.dharmendra.Springboottutorial.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.dharmendra.Springboottutorial.entity.Department;
import com.dharmendra.Springboottutorial.service.DepartmentService;

@RestController
public class DepartmentController {
	
	@Autowired
	private DepartmentService departmentService;
	
	@PostMapping("/department")
	public Department saveDepartment(@RequestBody Department department) {
		return departmentService.saveDepartment(department);
	}
	
	@GetMapping("/departments")
	public List<Department> getDepartmentList() {
		return departmentService.getDepartmentList();
	}
	
	@GetMapping("/departments/{id}")
	public Department getDepartmentById(@PathVariable("id") Long departmentId) {
		return departmentService.getDepartmentById(departmentId);
	}
	
	@DeleteMapping("/departments/{id}")
	public String deleteDepartmentById(@PathVariable("id") Long departmentId) {
		departmentService.deleteDepartmentById(departmentId);
		return "Department Deleted Successfully";
	}
	
	@PutMapping("/departments/{id}")
	public Department updateDepartment(@PathVariable("id") Long departmentId, @RequestBody Department department) {
		System.out.println("departmentId From Controller:: "+departmentId);
		return departmentService.updateDepartment(departmentId, department);
	}

}
