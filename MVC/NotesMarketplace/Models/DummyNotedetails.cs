using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace NotesMarketplace.Models
{
    public class DummyNotedetails
    {
        public int P_K_Note { get; set; }

        [Required]
        public int F_K_User { get; set; }

        public int F_K_NoteStatus { get; set; }

        [Required]
        public string Title { get; set; }

        [Required]
        public string Category { get; set; }

        public String BookPicture { get; set; }

        public string NoteAttachment { get; set; }
        public string NoteType { get; set; }

        [RegularExpression("^[0-9]*$", ErrorMessage = "Enter valid number")]
        public Nullable<int> NumberOfPages { get; set; }

        public HttpPostedFileBase Book_Picture { get; set; }

        [Required]
        public HttpPostedFileBase Note_Attachment { get; set; }
        public HttpPostedFileBase Note_Preview { get; set; }

        [Required]
        public string NotesDescription { get; set; }
        public string InstitutionName { get; set; }
        public string Country { get; set; }
        public string Course { get; set; }
        public string CourseCode { get; set; }
        public string Professor { get; set; }

        [Required]
        [RegularExpression("^[0-9]*$", ErrorMessage = "Enter valid price")]
        public int SellPrice { get; set; }
        public string NotePreview { get; set; }
        public Nullable<int> NoteSize { get; set; }
        public Nullable<System.DateTime> PublishedDate { get; set; }
        public string Remark { get; set; }
        public Nullable<System.DateTime> CreatedDate { get; set; }
        public Nullable<int> CreatedBy { get; set; }
        public Nullable<System.DateTime> ModifiedDate { get; set; }
        public Nullable<int> ModifiedBy { get; set; }
        public bool IsActive { get; set; }
    }
}