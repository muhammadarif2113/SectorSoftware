# Follows what we are trying to achive with this API

#     ---Prefix Verb---                   ---URI Pattern---                       ---Controller#Action---

#      api_v1_jobs GET                 /api/v1/jobs(.:format)                         api/v1/jobs#index  
#                  POST                /api/v1/jobs(.:format)                         api/v1/jobs#create 
#   new_api_v1_job GET                 /api/v1/jobs/new(.:format)                     api/v1/jobs#new    
# editt_api_v1_job GET                 /api/v1/jobs/:id/edit(.:format)                api/v1/jobs#edit   
#       api_v1_job GET                 /api/v1/jobs/:id(.:format)                     api/v1/jobs#show   
#                  PATCH               /api/v1/jobs/:id(.:format)                     api/v1/jobs#update 
#                  PUT                 /api/v1/jobs/:id(.:format)                     api/v1/jobs#update 
#                  DELETE              /api/v1/jobs/:id(.:format)                     api/v1/jobs#destroy
#                  GET                 /api/v1/jobs(.:format)                         api/v1/jobs#index  
#                  POST                /api/v1/jobs(.:format)                         api/v1/jobs#create
#                  GET                 /api/v1/jobs/new(.:format)                     api/v1/jobs#new
#                  GET                 /api/v1/jobs/:id/edit(.:format)                api/v1/jobs#edit
#                  GET                 /api/v1/jobs/:id(.:format)                     api/v1/jobs#show
#                  PATCH               /api/v1/jobs/:id(.:format)                     api/v1/jobs#update
#                  PUT                 /api/v1/jobs/:id(.:format)                     api/v1/jobs#update

require "json"
module Api
    module V1

        # API methods class
        class JobsController < ApplicationController

            # first method for getting everything from db
            def index
                jobs = Job.order('created_at DESC');
                render json: {status:'SUCCESS', message:'Jobs Loaded', data:jobs},status: :ok
            end

            # 2nd method for specific information
            def show
                job = Job.find(params[:id]);
                render json: {status:'SUCCESS', message:'Jobs Loaded', data:job},status: :ok
            end

            # 3rd method to create a new entry into the datadase
            def create
                job = Job.new(job_params)                
            
                if job.save
                    render json: {status:'SUCCESS', message:'Job Added', data:job},status: :ok
                else
                    render json: {status:'FAILURE', message:'Job Not Saved', data:job.errors},status: :unprocessable_entity
                end
            end
            
            # method to delete
            def destroy
                job = Job.find(params[:id])
                job.destroy
                render json: {status:'SUCCESS', message:'Job Deleted', data:job},status: :ok
            end          

            # update the data base with the data change
            def update
                job = Job.find(params[:id])
                if job.update_attributes(job_params)
                    render json: {status:'SUCCESS', message:'Job Updated', data:job},status: :ok
                else
                    render json: {status:'FAILURE', message:'Job Not Updated', data:job.errors},status: :unprocessable_entity
                end                
            end

            # private parameter variable to create
            # job_title, company, lucation, summary and url and white listed
            private

            def job_params
                params.permit(:job_title, :company, :location, :summary, :url)
            end

        end
    end
end
