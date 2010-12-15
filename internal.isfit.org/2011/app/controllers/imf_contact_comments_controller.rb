class ImfContactCommentsController < ApplicationController
    # GET /imf_contact_comments/1/edit
  def edit
    @imf_contact_comment = ImfContactComment.find(params[:id])
  end

  # POST /imf_contact_comments
  # POST /imf_contact_comments.xml
  def create
    @imf_contact_comment = ImfContactComment.new(params[:imf_contact_comment])

    respond_to do |format|
    @imf_contact_comment.save
        flash[:notice] = 'ImfContactComment was successfully created.'
        format.html { render :controller => imf_contact_units, :action => show, :id => @imf_contact_comment.imf_contact_unit_id }
        format.js
    end
  end

  # PUT /imf_contact_comments/1
  # PUT /imf_contact_comments/1.xml
  def update
    @imf_contact_comment = ImfContactComment.find(params[:id])

    respond_to do |format|
      if @imf_contact_comment.update_attributes(params[:imf_contact_comment])
        flash[:notice] = 'ImfContactComment was successfully updated.'
        format.html { redirect_to(@imf_contact_comment) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @imf_contact_comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /imf_contact_comments/1
  # DELETE /imf_contact_comments/1.xml
  def destroy
    @imf_contact_comment = ImfContactComment.find(params[:id])
    @imf_contact_comment.destroy

    respond_to do |format|
      format.html { redirect_to(imf_contact_comments_url) }
      format.xml  { head :ok }
    end
  end
end
