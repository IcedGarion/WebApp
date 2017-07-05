package Actions;

import Beans.AnalysisDateBean;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AddAnalysis extends Action
{
    @Override
    public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception
    {
        AnalysisDateBean bean = ((AnalysisDateBean) form);

        //salva soltanto i dati in session
        request.getSession().setAttribute("AnalysisData", bean);

        return mapping.findForward("ADD_ANALYSIS_OK");
    }
}
