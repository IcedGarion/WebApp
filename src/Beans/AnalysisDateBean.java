package Beans;

import org.apache.struts.action.ActionForm;

public class AnalysisDateBean extends ActionForm
{
    private String start;
    private String end;

    public AnalysisDateBean()
    { }

    public String getStart() {
        return start;
    }

    public void setStart(String start) {
        this.start = start;
    }

    public String getEnd() {
        return end;
    }

    public void setEnd(String end) {
        this.end = end;
    }
}
