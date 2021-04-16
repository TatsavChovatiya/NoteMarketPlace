namespace NotesMarketplace
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.Web;

    public partial class SystemConfiguration
    {
        public int ID { get; set; }

        [EmailAddress]
        [Display(Name = "emailid")]
        [Required(ErrorMessage = "Required")]
        public string EmaillId1 { get; set; }

        [EmailAddress]
        [Display(Name = "emailid")]
        [Required(ErrorMessage = "Required")]
        public string EmailId2 { get; set; }

        [Phone]
        [RegularExpression("^[0-9]*$", ErrorMessage = "Enter valid phonenumber")]
        [Required(ErrorMessage = "Required")]
        public string PhoneNumber { get; set; }

        public string DefaultProfilePicture { get; set; }

        public HttpPostedFileBase DPP { get; set; }

        public string DefaultNotePreview { get; set; }

        public HttpPostedFileBase DNP { get; set; }

        [MaxLength(100)]
        [Url]
        [Required(ErrorMessage = "Required")]
        public string FacebookUrl { get; set; }
        [Required(ErrorMessage = "Required")]
        [MaxLength(100)]
        [Url]
        public string TwitterUrl { get; set; }
        [Required(ErrorMessage = "Required")]
        [MaxLength(100)]
        [Url]
        public string LinkInUrl { get; set; }
        public Nullable<System.DateTime> CreatedDate { get; set; }
        public Nullable<int> CreatedBy { get; set; }
        public Nullable<System.DateTime> ModifiedDate { get; set; }
        public Nullable<int> ModifiedBy { get; set; }
    }
}
