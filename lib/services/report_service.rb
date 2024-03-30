class ReportService

  def report
    report_repository.report
  end

  private

  def report_repository
    @report_repository ||= ReportRepository.new
  end
end