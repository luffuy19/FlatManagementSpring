package com.chainsys.flatmanagement.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.chainsys.flatmanagement.model.Visitor;

@Repository
public interface VisitorDao {
	public void addVisitor(Visitor visitor) ;
    public void outVisitor(Visitor visitor) ;
    public List<Visitor> viewVisitor(String days) ;
}
