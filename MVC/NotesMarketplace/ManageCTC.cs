//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace NotesMarketplace
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;

    public partial class ManageCTC
    {
        public int ID { get; set; }
        public int F_K_CTC { get; set; }
        [Required(ErrorMessage = "Required...")]
        public string Value { get; set; }
        [Required(ErrorMessage = "Required...")]
        public string Description { get; set; }
        public Nullable<int> CountryCode { get; set; }
        public Nullable<System.DateTime> CreatedDate { get; set; }
        public Nullable<int> CreatedBy { get; set; }
        public Nullable<System.DateTime> ModifiedDate { get; set; }
        public Nullable<int> ModifiedBy { get; set; }
        public bool IsActive { get; set; }

        public virtual CTC CTC { get; set; }
    }
}