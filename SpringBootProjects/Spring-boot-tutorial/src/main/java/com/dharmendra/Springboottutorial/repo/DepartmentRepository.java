package com.dharmendra.Springboottutorial.repo;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.dharmendra.Springboottutorial.entity.Department;

@Repository
public interface DepartmentRepository extends JpaRepository<Department,Long >{

}
