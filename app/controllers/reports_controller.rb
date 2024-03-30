class ReportsController < ApplicationController

  def index
    render json: report_service.report
  end

  private

  def report_service
    @report_service ||= ReportService.new
  end

end

