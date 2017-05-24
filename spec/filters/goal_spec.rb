# encoding: utf-8
require_relative '../spec_helper'
require "logstash/filters/goal"

describe LogStash::Filters::Goal do

  describe "Filtro para buscador" do
    let(:config) do <<-CONFIG
      filter {
        goal {
          type => "event"
          category => "buscador"
          action => ""
        }
      }
    CONFIG
    end

    sample("category" => "buscador") do
      expect(subject.get('[goal][goal_name]')).to eq('dm_buscador_interno')
    end
  end

  describe "Filtro para email" do
    let(:config) do <<-CONFIG
      filter {
        goal {
          type => "event"
          category => "addthis"
          action => "email"
        }
      }
    CONFIG
    end

    sample("action" => "email") do
      expect(subject.get('[goal][goal_name]')).to eq('dm_compartir_email')
    end
  end

  describe "Filtro para redes sociales" do
    let(:config) do <<-CONFIG
      filter {
        goal {
          type => "event"
          category => "addthis"
          action => "rrss"
        }
      }
    CONFIG
    end

    sample("action" => "rrss") do
      expect(subject.get('[goal][goal_name]')).to eq('dm_compartir_redes_sociales')
    end
  end

  describe "Filtro para formulario para otros" do
    let(:config) do <<-CONFIG
      filter {
        goal {
          type => "page"
          category => "contacto.php#enviar-DMForm-Random"
          action => ""
        }
      }
    CONFIG
    end

    sample("category" => "contacto.php#enviar-DMForm-Random") do
      expect(subject.get('[goal][goal_name]')).to eq('dm_formularios')
    end
  end

  describe "Filtro para formulario contacto" do
    let(:config) do <<-CONFIG
      filter {
        goal {
          type => "page"
          category => "contacto.php#enviar-DMForm-Contacto"
          action => ""
        }
      }
    CONFIG
    end

    sample("category" => "contacto.php#enviar-DMForm-Contacto") do
      expect(subject.get('[goal][goal_name]')).to eq('dm_formularios_contacto')
    end
  end

end
