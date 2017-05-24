# Logstash Filter Goal

This is a plugin for [Logstash](https://github.com/elastic/logstash).

It is fully free and fully open source. The license is Apache 2.0, meaning you are pretty much free to use it however you want in whatever way.

## Documentation

This plugin filters http referer and transforms it into rich information. The are several kind of goals:

- dm_buscador_interno: Type=event AND Category=buscador
- dm_compartir_email: Type=event AND Category=addthis AND Action=email
- dm_compartir_redes_sociales: Type=event AND Category=addthis AND Action=REGEX(^(?!email$).*)
- dm_contacto_mailto: Type=event AND Category=email
- dm_descarga: Type=event AND Category=descarga
- dm_formularios: Type=page AND Page=REGEX((.*)#enviar-DMForm-(?!Contacto(.*)$|Newsletter(.*)$)(.*))
- dm_formularios_contacto: Type=page AND Page=REGEX((.*)#enviar-DMForm-Contacto(.*))
- dm_formularios_newsletter: Type=page AND REGEX((.*)#enviar-DMForm-Newsletter(.*))
- dm_mostrat_telefono_fax: Type=event AND Category=mostrar

## Need Help?

Need help? Try #logstash on freenode IRC or the https://discuss.elastic.co/c/logstash discussion forum.
You can also write directly to the creator: unai@acc.com.es

## Installation

Download the plugin and follow this instructions to install it:
```sh
gem build logstash-filter-goal.gemspec
bin/logstash-plugin install /path-to-downloaded-plugin/logstash-filter-goal-0.1.0.gem
initctl restart logstash
```

## Contributing

All contributions are welcome: ideas, patches, documentation, bug reports, complaints, and even something you drew up on a napkin.

Programming is not a required skill. Whatever you've seen about open source and maintainers or community members  saying "send patches or die" - you will not see that here.

It is more important to the community that you are able to contribute.

For more information about contributing, see the [CONTRIBUTING](https://github.com/elastic/logstash/blob/master/CONTRIBUTING.md) file.
