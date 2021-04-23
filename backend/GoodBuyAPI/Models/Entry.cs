﻿using System;
using System.ComponentModel.DataAnnotations;

namespace GoodBuyAPI.Models
{
    public class Entry
    {
        [Key]
        public ulong BarcodeId { get; set; }
        public string Name { get; set; }
        public string Link { get; set; }

        [Display(Name = "Created Date")]
        [DataType(DataType.Date)]
        [DisplayFormat(DataFormatString = "{0:dd-MM-yyyy}", ApplyFormatInEditMode = true)]
        public DateTime CreatedDate { get; set; }
    }
}

