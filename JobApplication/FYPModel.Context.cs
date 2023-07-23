﻿//------------------------------------------------------------------------------
// <auto-generated>
//    This code was generated from a template.
//
//    Manual changes to this file may cause unexpected behavior in your application.
//    Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace JobApplication
{
    using System;
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    using System.Data.Objects;
    using System.Data.Objects.DataClasses;
    using System.Linq;
    
    public partial class FYP_TEST_DBEntities : DbContext
    {
        public FYP_TEST_DBEntities()
            : base("name=FYP_TEST_DBEntities")
        {
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
        public DbSet<tbl_City> tbl_City { get; set; }
        public DbSet<tbl_department> tbl_department { get; set; }
        public DbSet<tbl_jobtype> tbl_jobtype { get; set; }
        public DbSet<tbl_positions> tbl_positions { get; set; }
        public DbSet<tbl_rounds> tbl_rounds { get; set; }
        public DbSet<tbl_Users> tbl_Users { get; set; }
        public DbSet<tbl_PostedJobs> tbl_PostedJobs { get; set; }
        public DbSet<tbl_Candidate> tbl_Candidate { get; set; }
        public DbSet<tbl_Ex_Interview_Round1> tbl_Ex_Interview_Round1 { get; set; }
        public DbSet<tbl_Ex_Task_Round3> tbl_Ex_Task_Round3 { get; set; }
        public DbSet<tbl_Ex_Quiz_Round2> tbl_Ex_Quiz_Round2 { get; set; }
        public DbSet<tbl_results_round2> tbl_results_round2 { get; set; }
        public DbSet<tbl_Task> tbl_Task { get; set; }
        public DbSet<tbl_questionBank> tbl_questionBank { get; set; }
        public DbSet<database_firewall_rules> database_firewall_rules { get; set; }
    
        public virtual ObjectResult<sp_GetInterviewQuestions_Result> sp_GetInterviewQuestions(Nullable<long> jobCategoryID, Nullable<long> jobTypeID)
        {
            var jobCategoryIDParameter = jobCategoryID.HasValue ?
                new ObjectParameter("JobCategoryID", jobCategoryID) :
                new ObjectParameter("JobCategoryID", typeof(long));
    
            var jobTypeIDParameter = jobTypeID.HasValue ?
                new ObjectParameter("JobTypeID", jobTypeID) :
                new ObjectParameter("JobTypeID", typeof(long));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<sp_GetInterviewQuestions_Result>("sp_GetInterviewQuestions", jobCategoryIDParameter, jobTypeIDParameter);
        }
    
        public virtual ObjectResult<sp_GetJobPostDetail_Result> sp_GetJobPostDetail()
        {
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<sp_GetJobPostDetail_Result>("sp_GetJobPostDetail");
        }
    
        public virtual ObjectResult<sp_GetTask_Result> sp_GetTask(Nullable<long> positionID, Nullable<long> jobTypeID)
        {
            var positionIDParameter = positionID.HasValue ?
                new ObjectParameter("PositionID", positionID) :
                new ObjectParameter("PositionID", typeof(long));
    
            var jobTypeIDParameter = jobTypeID.HasValue ?
                new ObjectParameter("JobTypeID", jobTypeID) :
                new ObjectParameter("JobTypeID", typeof(long));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<sp_GetTask_Result>("sp_GetTask", positionIDParameter, jobTypeIDParameter);
        }
    
        public virtual ObjectResult<sp_DashboardCount_Result> sp_DashboardCount()
        {
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<sp_DashboardCount_Result>("sp_DashboardCount");
        }
    
        public virtual ObjectResult<sp_GetCandidateDetail_Result> sp_GetCandidateDetail(Nullable<long> jobID)
        {
            var jobIDParameter = jobID.HasValue ?
                new ObjectParameter("JobID", jobID) :
                new ObjectParameter("JobID", typeof(long));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<sp_GetCandidateDetail_Result>("sp_GetCandidateDetail", jobIDParameter);
        }
    
        public virtual ObjectResult<sp_ViewQuestionBank_Result> sp_ViewQuestionBank(Nullable<long> candidateID)
        {
            var candidateIDParameter = candidateID.HasValue ?
                new ObjectParameter("CandidateID", candidateID) :
                new ObjectParameter("CandidateID", typeof(long));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<sp_ViewQuestionBank_Result>("sp_ViewQuestionBank", candidateIDParameter);
        }
    
        public virtual ObjectResult<sp_ReportQuestionBank_Result> sp_ReportQuestionBank(Nullable<long> positionID, Nullable<long> jobTyoeID)
        {
            var positionIDParameter = positionID.HasValue ?
                new ObjectParameter("PositionID", positionID) :
                new ObjectParameter("PositionID", typeof(long));
    
            var jobTyoeIDParameter = jobTyoeID.HasValue ?
                new ObjectParameter("JobTyoeID", jobTyoeID) :
                new ObjectParameter("JobTyoeID", typeof(long));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<sp_ReportQuestionBank_Result>("sp_ReportQuestionBank", positionIDParameter, jobTyoeIDParameter);
        }
    
        public virtual ObjectResult<sp_ReportRoundWise_Result> sp_ReportRoundWise(Nullable<long> candidateID, string status, Nullable<long> roundNo, Nullable<long> positionID, Nullable<long> departmentID)
        {
            var candidateIDParameter = candidateID.HasValue ?
                new ObjectParameter("CandidateID", candidateID) :
                new ObjectParameter("CandidateID", typeof(long));
    
            var statusParameter = status != null ?
                new ObjectParameter("Status", status) :
                new ObjectParameter("Status", typeof(string));
    
            var roundNoParameter = roundNo.HasValue ?
                new ObjectParameter("RoundNo", roundNo) :
                new ObjectParameter("RoundNo", typeof(long));
    
            var positionIDParameter = positionID.HasValue ?
                new ObjectParameter("PositionID", positionID) :
                new ObjectParameter("PositionID", typeof(long));
    
            var departmentIDParameter = departmentID.HasValue ?
                new ObjectParameter("DepartmentID", departmentID) :
                new ObjectParameter("DepartmentID", typeof(long));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<sp_ReportRoundWise_Result>("sp_ReportRoundWise", candidateIDParameter, statusParameter, roundNoParameter, positionIDParameter, departmentIDParameter);
        }
    
        public virtual ObjectResult<sp_CandidateDetail_Result> sp_CandidateDetail(string name, string contact, string cNIC, string email, Nullable<long> experience, Nullable<long> cityID, Nullable<long> positionID, Nullable<long> jobTypeID, Nullable<long> deptID)
        {
            var nameParameter = name != null ?
                new ObjectParameter("Name", name) :
                new ObjectParameter("Name", typeof(string));
    
            var contactParameter = contact != null ?
                new ObjectParameter("Contact", contact) :
                new ObjectParameter("Contact", typeof(string));
    
            var cNICParameter = cNIC != null ?
                new ObjectParameter("CNIC", cNIC) :
                new ObjectParameter("CNIC", typeof(string));
    
            var emailParameter = email != null ?
                new ObjectParameter("Email", email) :
                new ObjectParameter("Email", typeof(string));
    
            var experienceParameter = experience.HasValue ?
                new ObjectParameter("Experience", experience) :
                new ObjectParameter("Experience", typeof(long));
    
            var cityIDParameter = cityID.HasValue ?
                new ObjectParameter("CityID", cityID) :
                new ObjectParameter("CityID", typeof(long));
    
            var positionIDParameter = positionID.HasValue ?
                new ObjectParameter("PositionID", positionID) :
                new ObjectParameter("PositionID", typeof(long));
    
            var jobTypeIDParameter = jobTypeID.HasValue ?
                new ObjectParameter("JobTypeID", jobTypeID) :
                new ObjectParameter("JobTypeID", typeof(long));
    
            var deptIDParameter = deptID.HasValue ?
                new ObjectParameter("DeptID", deptID) :
                new ObjectParameter("DeptID", typeof(long));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<sp_CandidateDetail_Result>("sp_CandidateDetail", nameParameter, contactParameter, cNICParameter, emailParameter, experienceParameter, cityIDParameter, positionIDParameter, jobTypeIDParameter, deptIDParameter);
        }
    
        public virtual ObjectResult<sp_GetFiles_Result> sp_GetFiles(string reportType, Nullable<long> iD)
        {
            var reportTypeParameter = reportType != null ?
                new ObjectParameter("ReportType", reportType) :
                new ObjectParameter("ReportType", typeof(string));
    
            var iDParameter = iD.HasValue ?
                new ObjectParameter("ID", iD) :
                new ObjectParameter("ID", typeof(long));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<sp_GetFiles_Result>("sp_GetFiles", reportTypeParameter, iDParameter);
        }
    
        public virtual ObjectResult<sp_GetCandidateResultStatus_Result> sp_GetCandidateResultStatus()
        {
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<sp_GetCandidateResultStatus_Result>("sp_GetCandidateResultStatus");
        }
    }
}
