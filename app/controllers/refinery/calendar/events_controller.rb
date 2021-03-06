module Refinery
  module Calendar
    class EventsController < ::ApplicationController
      before_action :find_page, except: :archive

      def index
        # @events = Event.upcoming.order('refinery_calendar_events.starts_at DESC')
        @events = Event.all.order('refinery_calendar_events.starts_at DESC')
        @date = params[:start_date] ? Date.parse(params[:start_date]) : Date.today
        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @event in the line below:
        present(@page)
      end

      def show
        @event = Event.friendly.find(params[:id])

        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @event in the line below:
        present(@page)
      end

      def archive
        @events = Event.archive.order('refinery_calendar_events.starts_at DESC')
        render :template => 'refinery/calendar/events/index'
      end

      protected
      def find_page
        @page = ::Refinery::Page.where(:link_url => "/calendar/events").first
      end

    end
  end
end
