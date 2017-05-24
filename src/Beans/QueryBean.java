package Beans;

import org.apache.struts.action.ActionForm;

/**
 * Created by ubuntu on 12/05/17.
 */
public class QueryBean extends ActionForm
{
    private String query;

    public QueryBean()
    {}

    public String getQuery() {
        return query;
    }

    public void setQuery(String name) {
        this.query = name;
    }
}
