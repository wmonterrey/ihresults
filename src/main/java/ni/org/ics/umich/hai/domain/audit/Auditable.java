package ni.org.ics.umich.hai.domain.audit;

public interface Auditable {
	
	public boolean isFieldAuditable(String fieldname);

}
