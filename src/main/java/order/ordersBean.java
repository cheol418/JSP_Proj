package order;

public class ordersBean {
		private String mname;
		private String mid;
		private String pname;
		private int qty; //주문수량
		private int amount;
		
		public ordersBean(String mname2, String mid2, String ppname, int oqty, int oamount) {
			
		}
		
		public String getMname() {
			return mname;
		}
		public void setMname(String mname) {
			this.mname = mname;
		}
		public String getMid() {
			return mid;
		}
		public void setMid(String mid) {
			this.mid = mid;
		}
		public String getPname() {
			return pname;
		}
		public void setPname(String pname) {
			this.pname = pname;
		}
		public int getQty() {
			return qty;
		}
		public void setQty(int qty) {
			this.qty = qty;
		}
		public int getAmount() {
			return amount;
		}
		public void setAmount(int amount) {
			this.amount = amount;
		}
	

	
}	
