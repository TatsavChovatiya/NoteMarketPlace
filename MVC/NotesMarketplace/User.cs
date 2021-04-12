namespace NotesMarketplace
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;

    public partial class User
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public User()
        {
            this.AdminProfiles = new HashSet<AdminProfile>();
            this.DownloadedNotes = new HashSet<DownloadedNote>();
            this.DownloadedNotes1 = new HashSet<DownloadedNote>();
            this.Feedbacks = new HashSet<Feedback>();
            this.NotesDetails = new HashSet<NotesDetail>();
            this.SpamReports = new HashSet<SpamReport>();
            this.Statistics = new HashSet<Statistic>();
            this.UserProfiles = new HashSet<UserProfile>();
        }

        public int P_K_User { get; set; }
        public int F_K_UserRoles { get; set; }

        [Display(Name = "first name")]
        [Required]
        [RegularExpression("^[a-zA-Z]*$", ErrorMessage = "Enter valid name")]
        public string FirstName { get; set; }

        [Required]
        [Display(Name = "last name")]
        [RegularExpression("^[a-zA-Z]*$", ErrorMessage = "Enter valid name")]
        public string LastName { get; set; }

        [Required]
        [Display(Name = "Email address")]
        [EmailAddress]
        public string EmailId { get; set; }

        [Required]
        [Display(Name = "password")]
        [MinLength(6, ErrorMessage = "Requird Minimum length 6")]
        // [RegularExpression(@"^(?=.[a-z])(?=.\d)(?=.[@$!%?&])(\\S)[A-Za-z\d@$!%?&]{6,24}$", ErrorMessage = "Password must be strong")]
        public string Password { get; set; }

        [Required]
        [Compare("Password")]
        [Display(Name = "confirm password")]
        public string Password2 { get; set; }

        public bool IsEmailVerified { get; set; }
        public bool IsDetailsSubmitted { get; set; }
        public bool RememberMe { get; set; }
        public Nullable<System.DateTime> CreaatedDate { get; set; }
        public Nullable<int> CreatedBy { get; set; }
        public Nullable<System.DateTime> ModifiedDate { get; set; }
        public Nullable<int> ModifiedBy { get; set; }
        public bool IsActive { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<AdminProfile> AdminProfiles { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<DownloadedNote> DownloadedNotes { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<DownloadedNote> DownloadedNotes1 { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Feedback> Feedbacks { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<NotesDetail> NotesDetails { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<SpamReport> SpamReports { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Statistic> Statistics { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<UserProfile> UserProfiles { get; set; }
        public virtual UserRole UserRole { get; set; }
    }
}
