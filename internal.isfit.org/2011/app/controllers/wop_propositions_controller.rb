class WopPropositionsController < ApplicationController
  # GET /wop_propositions
  # GET /wop_propositions.xml
  def index
    @wop_propositions = WopProposition.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @wop_propositions }
    end
  end

  # GET /wop_propositions/1
  # GET /wop_propositions/1.xml
  def show
    @wop_proposition = WopProposition.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @wop_proposition }
    end
  end

end
