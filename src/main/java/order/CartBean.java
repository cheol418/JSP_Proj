package order;

import java.util.ArrayList;

import shop.ProductBean;
import shop.ProductDao;


public class CartBean { // 장바구니 
	
	public ArrayList<ProductBean> clist = null;
	
	public CartBean(){
		clist = new ArrayList<ProductBean>(); 
	}
	public void addProduct(String pnum, String oqty) { 
	
		int iPnum = Integer.parseInt(pnum);
		int ioqty = Integer.parseInt(oqty);
		
		ProductDao pdao = ProductDao.getInstance();
		ProductBean newPd = pdao.selectByPnum(Integer.parseInt(pnum));
		
		for(int i=0;i<clist.size();i++) { 
			int cPnum = clist.get(i).getPnum();
			if(cPnum == iPnum) {
				int cPqty = clist.get(i).getPqty();
				clist.get(i).setPqty(cPqty+ioqty); //주문수량
				clist.get(i).setTotalPrice(newPd.getPrice()*(cPqty+ioqty));
				clist.get(i).setTotalPoint(clist.get(i).getPoint()*(cPqty+ioqty));
				return;
			}
		}
		
		newPd.setPqty(ioqty);
		newPd.setTotalPrice(newPd.getPrice()*ioqty);
		newPd.setTotalPoint(newPd.getPoint()*ioqty);
		clist.add(newPd);
		
	}//addProduct
	
	public void addOrder(String pnum, String oqty) { 
		
		int iPnum = Integer.parseInt(pnum);
		int ioqty = Integer.parseInt(oqty);
		
		ProductDao pdao = ProductDao.getInstance();
		ProductBean newPd = pdao.selectByPnum(Integer.parseInt(pnum));
		
		for(int i=0;i<clist.size();i++) { // 
			int cPnum = clist.get(i).getPnum();
			if(cPnum == iPnum) {
				clist.get(i).setPqty(ioqty); //주문수량
				clist.get(i).setTotalPrice(newPd.getPrice()*(ioqty));
				clist.get(i).setTotalPoint(clist.get(i).getPoint()*(ioqty));
				return;
			}
		}
		
		newPd.setPqty(ioqty);
		newPd.setTotalPrice(newPd.getPrice()*ioqty);
		newPd.setTotalPoint(newPd.getPoint()*ioqty);
		clist.add(newPd);
		
	}//addOrder
	
	public ArrayList<ProductBean> getAllProducts(){
		return clist;
	}//getAllProducts
	
	public void setEdit(String pnum,String oqty) { 
		for(ProductBean pd : clist) { // 
			if(pd.getPnum() == Integer.parseInt(pnum) ) {
				pd.setPqty(Integer.parseInt(oqty)); 
				int totalPrice = pd.getPqty() * pd.getPrice();
				int totalPoint = pd.getPqty() * pd.getPoint();
				
				pd.setTotalPoint(totalPoint);
				pd.setTotalPrice(totalPrice);
				
			}
			
		}//for
	}//setEdit
	
	public void removeProduct(int pnum){
		for(int i=0;i<clist.size();i++) { // 
			if(clist.get(i).getPnum()==pnum) {
				clist.remove(i);
			}//if
		}//for
	}//removeProduct
	
	public void removeAllProduct(){
			clist.removeAll(clist);
	}//removeAllProduct
}


