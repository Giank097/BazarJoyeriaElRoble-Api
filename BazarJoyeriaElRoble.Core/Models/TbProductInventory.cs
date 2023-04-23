using System;
using System.Collections.Generic;

namespace BazarJoyeriaElRoble.Infrastructure;

public partial class TbProductInventory
{
    public int Id { get; set; }

    public int Quantity { get; set; }

    public DateTime? CreatedAt { get; set; }

    public DateTime? ModifiedAt { get; set; }

    public DateTime? DeletedAt { get; set; }

    public virtual TbProduct IdNavigation { get; set; } = null!;
}
