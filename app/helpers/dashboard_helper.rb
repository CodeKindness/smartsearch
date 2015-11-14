module DashboardHelper
  def company_activity_ratio(company)
    (company.activity.to_f * 100.0).round(0)
  end

  def company_activity_progress(company)
    case
    when company_activity_ratio(company) >= 57
      return 'success'
    when company_activity_ratio(company) >= 28
      return 'warning'
    else
      return 'danger'
    end
  end
end
