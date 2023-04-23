using System;
using System.Collections.Generic;

namespace BazarJoyeriaElRoble.Infrastructure;

public partial class TbDiscount
{
    public int Id { get; set; }

    public string Name { get; set; } = null!;

    public string? Description { get; set; }

    public decimal DiscountPercent { get; set; }

    public sbyte Active { get; set; }

    public DateTime? CreatedAt { get; set; }

    public DateTime? ModifiedAt { get; set; }

    public DateTime? DeletedAt { get; set; }

    public virtual ICollection<TbProduct> TbProducts { get; set; } = new List<TbProduct>();
}
