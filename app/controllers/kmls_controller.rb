class KmlsController < ApplicationController
  # GET /kmls
  # GET /kmls.xml
  def index
    @kmls = Kml.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @kmls }
    end
  end

  # GET /kmls/1
  # GET /kmls/1.xml
  def show
    @kml = Kml.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @kml.get_xml() }
    end
  end

  # GET /kmls/new
  # GET /kmls/new.xml
  def new
    @kml = Kml.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /kmls/1/edit
  def edit
    @kml = Kml.find(params[:id])
  end

  # POST /kmls
  # POST /kmls.xml
  def create
    @kml = Kml.new(params[:kml])

    respond_to do |format|
        uploaded_io = params[:kml][:contents]

        if uploaded_io
          @kml.original_filename = uploaded_io.original_filename
          File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'w') do |file|
            file.write(uploaded_io.read)
          end
        end

        if @kml.save
        format.html { redirect_to(@kml, :notice => 'Kml was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /kmls/1
  # PUT /kmls/1.xml
  def update
    @kml = Kml.find(params[:id])

    respond_to do |format|
      if @kml.update_attributes(params[:kml])
        format.html { redirect_to(@kml, :notice => 'Kml was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /kmls/1
  # DELETE /kmls/1.xml
  def destroy
    @kml = Kml.find(params[:id])
    @kml.destroy

    respond_to do |format|
      format.html { redirect_to(kmls_url) }
    end
  end
end
