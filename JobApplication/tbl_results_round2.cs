//------------------------------------------------------------------------------
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
    using System.Collections.Generic;
    
    public partial class tbl_results_round2
    {
        public int ID { get; set; }
        public Nullable<int> CandidateID { get; set; }
        public Nullable<int> Round2RecordID { get; set; }
        public Nullable<int> QuestionID { get; set; }
        public string CorrectAnswer { get; set; }
    
        public virtual tbl_Candidate tbl_Candidate { get; set; }
        public virtual tbl_Ex_Quiz_Round2 tbl_Ex_Quiz_Round2 { get; set; }
        public virtual tbl_questionBank tbl_questionBank { get; set; }
    }
}
