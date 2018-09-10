require 'rails_helper'

RSpec.describe "Todos", type: :request do
  let!(:todos) { create_list(:todo, 10) }
  let(:todo_id) { todos.first.id }

  describe "GET /todos" do
    before { get '/todos' }

    it 'return http status 200' do
      expect(response).to have_http_status(200)
    end

    it 'return todos data' do
      expect(json).not_to be_empty
      expect(json["data"].size).to eq(10)
    end 
  end

  describe "GET /todos/:id" do

    context "when record exist" do
      before { get "/todos/#{todo_id}" }

      it 'return http status 200' do
        expect(response).to have_http_status(200)
      end

      it 'return todo data' do 
        expect(json).not_to be_empty
        expect(json['data']['id']).to eq(todo_id.to_s)
      end 
    end

    context "when record does not exist" do
      let(:todo_id) { 100 }
      before { get "/todos/#{todo_id}" }

      it 'return http status 404' do
        expect(response).to have_http_status(404)
      end

      it 'return a not found message' do 
        expect(json["error"]).to match(/Couldn't find Todo/)
      end 
    end
  end

  describe "POST /todos" do
    let(:valid_params) { { title: 'Interview', created_by: "Johan" } }

    context 'when the request is valid' do
      before { post '/todos', params: valid_params }

      it 'creates a todo' do
        expect(json["data"]["attributes"]["title"]).to eq("Interview")
      end

      it 'return status code 201' do 
        expect(response).to have_http_status(201)
      end
    end

    context "when the request is invalid" do
      before { post '/todos', params: { title: 'test' } }

      it 'return 422 status' do
        expect(response).to have_http_status(422)
      end

      it 'return an invalid message' do
        expect(json["error"]).to match(/Created by can't be blank/)
      end
    end
  end

  describe "PUT /todos:id" do
    
  end

  describe "DELETE /todos" do
    
  end
end
