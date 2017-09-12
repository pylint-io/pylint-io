class RepositoriesController < ApplicationController
  # before_action :set_repository, only: [:show, :edit, :update, :destroy]
  before_action :authenticate!


  # GET /repositories
  # GET /repositories.json
  def index
    @repositories = add_api_info(@current_user.repositories)
  end

  # GET /repositories/1
  # GET /repositories/1.json
  def show
    @repository = add_api_info(Repository.find(params[:id]))
  end

  # GET /repositories/new
  def new
    @repository = Repository.new
    @repository.service = "github"

    # see if we have any of the github repos already
    repositories = @current_user.repositories
    @github_repositories = []
    @github.repos.each do |repo|
      if repo.fork
        # we have to fetch this because we need the parent info
        repo = @github.repository(repo.full_name)
      end
      # we gotta check this in case another user added the repository
      match = repositories.where(service: "github", owner: repo.owner.login, name: repo.name).first
      if match
        repo.pylint_link = repository_url(match)
      end
      @github_repositories.push(repo)
    end
  end

  # # GET /repositories/1/edit
  # def edit
  # end
  #
  # # POST /repositories
  # # POST /repositories.json
  # def create
  #   @repository = Repository.new(repository_params)
  #
  #   respond_to do |format|
  #     if @repository.save
  #       format.html { redirect_to @repository, notice: 'Repository was successfully created.' }
  #       format.json { render :show, status: :created, location: @repository }
  #     else
  #       format.html { render :new }
  #       format.json { render json: @repository.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end
  #
  # # PATCH/PUT /repositories/1
  # # PATCH/PUT /repositories/1.json
  # def update
  #   respond_to do |format|
  #     if @repository.update(repository_params)
  #       format.html { redirect_to @repository, notice: 'Repository was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @repository }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @repository.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end
  #
  # # DELETE /repositories/1
  # # DELETE /repositories/1.json
  # def destroy
  #   @repository.destroy
  #   respond_to do |format|
  #     format.html { redirect_to repositories_url, notice: 'Repository was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end
  #
  private

  def add_api_info(repos)
    # add more api info if the repo is a fork
    if repos.is_a? Enumerable
      repos.each do |repo|
        repo.api_info = @github.repository("#{repo.owner}/#{repo.name}")
      end
    else
      repos.api_info = @github.repository("#{repos.owner}/#{repos.name}")
    end
    return repos
  end
  #   # Use callbacks to share common setup or constraints between actions.
  #   def set_repository
  #     @repository = Repository.find(params[:id])
  #   end
  #
  #   # Never trust parameters from the scary internet, only allow the white list through.
  #   def repository_params
  #     params.fetch(:repository, {})
  #   end
end
