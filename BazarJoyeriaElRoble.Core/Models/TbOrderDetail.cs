using System;
using System.Collections.Generic;

namespace BazarJoyeriaElRoble.Infrastructure;

public partial class TbOrderDetail
{
    public int OrderId { get; set; }

    public int UserId { get; set; }

    public DateTime? CreatedAt { get; set; }

    public DateTime? ModifiedAt { get; set; }

    public DateTime? DeletedAt { get; set; }

    public virtual ICollection<TbOrderItem> TbOrderItems { get; set; } = new List<TbOrderItem>();

    public virtual TbUser User { get; set; } = null!;
}
