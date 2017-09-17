#
# Copyright (c) 2017 Muzo Labs
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# For a copy of the full license, see LICENSE file included in this
# distribution or http://www.gnu.org/license
#

class RepositoriesController < ApplicationController
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

  # POST /repositories
  # POST /repositories.json
  def create
    # TODO make sure they have github access to the repository
    # they are trying to create
    @repository = Repository.new(params.fetch(:repository, {}).permit(:service, :owner, :name))
    @repository.users << @current_user

    respond_to do |format|
      if @repository.save
        format.html { redirect_to @repository, notice: 'Repository successfully registered.' }
        format.json { render :show, status: :created, location: @repository }
      else
        format.html { redirect_to :new }
        format.json { render json: @repository.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /repositories/1
  # DELETE /repositories/1.json
  def destroy
    @repository = Repository.find(params[:id])
    @repository.destroy
    respond_to do |format|
      format.html { redirect_to repositories_url, notice: 'Repository was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
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
end
