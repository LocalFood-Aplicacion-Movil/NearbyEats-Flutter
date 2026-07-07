import 'package:flutter/material.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  static const _lastUpdated = '6 de julio de 2026';

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Términos y Condiciones')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            Text('Términos y Condiciones de NearbyEats', style: textTheme.headlineSmall),
            const SizedBox(height: 4),
            Text(
              'Última actualización: $_lastUpdated',
              style: textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.outline),
            ),
            const SizedBox(height: 24),
            const _Section(
              title: '1. Aceptación de los Términos',
              body:
                  'Al crear una cuenta o utilizar la aplicación NearbyEats ("la App"), aceptas quedar '
                  'vinculado por estos Términos y Condiciones y por nuestra Política de Privacidad. Si no '
                  'estás de acuerdo con alguna parte de estos términos, no debes utilizar la App.',
            ),
            const _Section(
              title: '2. Descripción del Servicio',
              body:
                  'NearbyEats es una aplicación que permite a grupos de personas encontrar restaurantes '
                  'convenientes según la ubicación geográfica de sus integrantes, calculando un puntaje de '
                  'viabilidad en función de la distancia y dispersión de los colaboradores respecto a cada '
                  'restaurante. La App se ofrece "tal cual" y puede cambiar, ampliarse o discontinuarse en '
                  'cualquier momento.',
            ),
            const _Section(
              title: '3. Licencia de Uso',
              body:
                  'Te otorgamos una licencia limitada, no exclusiva, intransferible y revocable para '
                  'instalar y utilizar la App en tus dispositivos personales, únicamente para tu uso '
                  'personal y de acuerdo con estos Términos. Todos los derechos no otorgados expresamente '
                  'quedan reservados.',
            ),
            const _Section(
              title: '4. Cuentas de Usuario',
              body:
                  'Para usar la App debes crear una cuenta con un nombre de usuario y contraseña. Eres '
                  'responsable de mantener la confidencialidad de tus credenciales y de toda actividad '
                  'realizada bajo tu cuenta. Debes notificarnos de inmediato ante cualquier uso no '
                  'autorizado de tu cuenta.',
            ),
            const _Section(
              title: '5. Uso Aceptable',
              body:
                  'Te comprometes a utilizar la App únicamente con fines lícitos y de acuerdo con su '
                  'propósito: organizar grupos, gestionar colaboradores y restaurantes, y calcular '
                  'puntajes de viabilidad para reuniones.',
            ),
            const _Section(
              title: '6. Conductas Prohibidas',
              body:
                  'No está permitido: (a) usar la App para fines ilegales o no autorizados; '
                  '(b) intentar acceder sin autorización a otras cuentas, sistemas o redes conectadas a la '
                  'App; (c) interferir con el funcionamiento de la App o los servidores; (d) cargar '
                  'información falsa, difamatoria o que infrinja derechos de terceros; (e) realizar '
                  'ingeniería inversa, descompilar o desensamblar la App salvo permiso legal expreso.',
            ),
            const _Section(
              title: '7. Suspensión y Terminación de la Cuenta',
              body:
                  'Nos reservamos el derecho de suspender o eliminar tu cuenta, con o sin previo aviso, '
                  'si incumples estos Términos o si detectamos un uso indebido de la App. Puedes solicitar '
                  'la eliminación de tu cuenta y datos asociados en cualquier momento contactándonos.',
            ),
            const _Section(
              title: '8. Propiedad Intelectual',
              body:
                  'La App, su código, diseño, logotipos y contenidos son propiedad de NearbyEats o de sus '
                  'licenciantes y están protegidos por leyes de propiedad intelectual. Ninguna disposición '
                  'de estos Términos te otorga derechos sobre nuestras marcas o contenidos, salvo la '
                  'licencia de uso descrita en la Sección 3.',
            ),
            const _Section(
              title: '9. Contenido y Datos del Usuario',
              body:
                  'Los datos que ingreses (grupos, colaboradores, restaurantes, direcciones) siguen siendo '
                  'de tu propiedad. Al usarlos en la App, nos otorgas una licencia limitada para '
                  'almacenarlos y procesarlos con el único fin de prestarte el servicio (por ejemplo, '
                  'calcular distancias y puntajes de viabilidad).',
            ),
            const _Section(
              title: '10. Privacidad',
              body:
                  'El uso de la App implica la recopilación y el procesamiento de datos como ubicación de '
                  'direcciones, nombre de usuario y datos de contacto de colaboradores. Consulta nuestra '
                  'Política de Privacidad para más información sobre cómo recopilamos, usamos y protegemos '
                  'tus datos.',
            ),
            const _Section(
              title: '11. Exclusión de Garantías',
              body:
                  'La App se proporciona "tal cual" y "según disponibilidad", sin garantías de ningún '
                  'tipo, expresas o implícitas. No garantizamos que la App esté libre de errores, sea '
                  'ininterrumpida o que los cálculos de viabilidad sean exactos en todos los casos.',
            ),
            const _Section(
              title: '12. Limitación de Responsabilidad',
              body:
                  'En la máxima medida permitida por la ley, NearbyEats no será responsable por daños '
                  'indirectos, incidentales, especiales o consecuentes derivados del uso o la '
                  'imposibilidad de uso de la App, incluyendo decisiones tomadas con base en los puntajes '
                  'de viabilidad calculados.',
            ),
            const _Section(
              title: '13. Cambios en los Términos',
              body:
                  'Podemos actualizar estos Términos en cualquier momento. Notificaremos cambios '
                  'relevantes dentro de la App o por otros medios razonables. El uso continuado de la App '
                  'tras la publicación de cambios constituye tu aceptación de los nuevos Términos.',
            ),
            const _Section(
              title: '14. Ley Aplicable',
              body:
                  'Estos Términos se rigen por las leyes de la República del Perú, sin perjuicio de sus '
                  'normas sobre conflicto de leyes. Cualquier disputa se someterá a los tribunales '
                  'competentes de dicha jurisdicción.',
            ),
            const _Section(
              title: '15. Contacto',
              body:
                  'Si tienes preguntas sobre estos Términos y Condiciones, puedes contactar al equipo '
                  'de soporte de NearbyEats a través de los canales de soporte disponibles dentro de la '
                  'aplicación.',
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final String title;
  final String body;

  const _Section({required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          Text(body, style: textTheme.bodyMedium),
        ],
      ),
    );
  }
}
