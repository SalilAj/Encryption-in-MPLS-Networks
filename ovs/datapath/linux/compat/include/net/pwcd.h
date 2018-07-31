/*
 * Copyright (c) 2014 Nicira, Inc.
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of version 2 of the GNU General Public
 * License as published by the Free Software Foundation.
 *
 * This program is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * General Public License for more details.
 */

#include <linux/if_ether.h>
#include <linux/netdevice.h>

#define PWCD_HLEN 4

struct pw_codeword_hdr {
	__be32 control_word_data;
};


//#ifdef MPLS_HEADER_IS_L3
/*static inline struct pw_codeword_hdr *pwcd_hdr(const struct sk_buff *skb)
{
    return (struct pw_codeword_hdr *)skb_network_header(skb);
}
*/
//#else
//#define mpls_hdr rpl_mpls_hdr

static inline struct pw_codeword_hdr *pwcd_hdr(const struct sk_buff *skb)
{
	return (struct pw_codeword_hdr *) (skb_mac_header(skb) + skb->mac_len);
}
