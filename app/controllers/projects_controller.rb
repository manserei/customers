class ProjectsController < InheritedResources::Base
  belongs_to :customer

  def update
    update! do |f|
      f.html { redirect_to [@project.customer, :projects] }
    end
  end
end
