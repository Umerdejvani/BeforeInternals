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
    
    public partial class tbl_positions
    {
        public tbl_positions()
        {
            this.tbl_PostedJobs = new HashSet<tbl_PostedJobs>();
            this.tbl_Task = new HashSet<tbl_Task>();
            this.tbl_questionBank = new HashSet<tbl_questionBank>();
        }
    
        public int ID { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
    
        public virtual ICollection<tbl_PostedJobs> tbl_PostedJobs { get; set; }
        public virtual ICollection<tbl_Task> tbl_Task { get; set; }
        public virtual ICollection<tbl_questionBank> tbl_questionBank { get; set; }
    }
}