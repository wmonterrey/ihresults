package ni.org.ics.umich.hai.language;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import ni.org.ics.umich.hai.domain.audit.Auditable;


@Entity
@Table(name = "messages", catalog = "hai")
public class MessageResource implements Serializable, Auditable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
    private String messageKey;
    private String catKey;
    private char pasive = '0';
    private String spanish;
    private String english;
    
    public MessageResource() {

	}

    @Id
    @Column(name = "messageKey", nullable = false)
    public String getMessageKey() {
        return messageKey;
    }

    public void setMessageKey(String messageKey) {
        this.messageKey = messageKey;
    }
    
    @Column(name = "catKey", nullable = true)
    public String getCatKey() {
		return catKey;
	}

	public void setCatKey(String catKey) {
		this.catKey = catKey;
	}

	@Column(name="catPasive", nullable = true, length = 1)
	public char getPasive() {
		return pasive;
	}

	public void setPasive(char pasive) {
		this.pasive = pasive;
	}

	@Column(name = "en", nullable = true)
    public String getEnglish() {
        return english;
    }

    public void setEnglish(String english) {
        this.english = english;
    }

    
    @Column(name = "es", nullable = true)
    public String getSpanish() {
		return spanish;
	}

	public void setSpanish(String spanish) {
		this.spanish = spanish;
	}

	@Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        MessageResource that = (MessageResource) o;

        if (messageKey != null ? !messageKey.equals(that.messageKey) : that.messageKey != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        return messageKey != null ? messageKey.hashCode() : 0;
    }
    
	@Override
	public boolean isFieldAuditable(String fieldname) {
		// TODO Auto-generated method stub
		return false;
	}

	

}
