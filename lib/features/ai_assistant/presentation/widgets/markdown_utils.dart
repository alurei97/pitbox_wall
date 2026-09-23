import 'package:flutter/material.dart';
import 'package:markdown/markdown.dart' as md;

/// Converts markdown text to a list of [InlineSpan] for rich text rendering.
/// Supports headers, bold, italic, bullet points, code blocks, and links.
List<InlineSpan> markdownToSpans(String markdownText, TextStyle? baseStyle) {
  final nodes = md.Document().parseLines(markdownText.split('\n'));
  final spans = <InlineSpan>[];
  for (final node in nodes) {
    _visitNode(node, spans, baseStyle);
  }

  // Remove trailing newlines that markdown parser adds after block elements.
  while (spans.isNotEmpty) {
    final last = spans.last;
    if (last is TextSpan && last.text != null && last.text!.trim().isEmpty) {
      spans.removeLast();
    } else {
      break;
    }
  }

  return spans;
}

void _visitNode(md.Node node, List<InlineSpan> spans, TextStyle? baseStyle) {
  if (node is md.Element) {
    final children = node.children ?? const <md.Node>[];
    switch (node.tag) {
      case 'h1':
      case 'h2':
      case 'h3':
      case 'h4':
      case 'h5':
      case 'h6':
        final headerStyle = baseStyle!.copyWith(
          fontWeight: FontWeight.w700,
          fontSize:
              (baseStyle.fontSize ?? 14) *
              (node.tag == 'h1'
                  ? 1.5
                  : node.tag == 'h2'
                  ? 1.3
                  : 1.1),
        );
        for (final child in children) {
          _visitNode(child, spans, headerStyle);
        }
        spans.add(TextSpan(text: '\n\n', style: baseStyle));
        break;

      case 'p':
        for (final child in children) {
          _visitNode(child, spans, baseStyle);
        }
        spans.add(TextSpan(text: '\n\n', style: baseStyle));
        break;

      case 'strong':
      case 'b':
        final boldStyle = baseStyle?.copyWith(fontWeight: FontWeight.w700);
        for (final child in children) {
          _visitNode(child, spans, boldStyle);
        }
        break;

      case 'em':
      case 'i':
        final italicStyle = baseStyle?.copyWith(fontStyle: FontStyle.italic);
        for (final child in children) {
          _visitNode(child, spans, italicStyle);
        }
        break;

      case 'code':
        final codeStyle = baseStyle?.copyWith(
          fontFamily: 'monospace',
          backgroundColor: Colors.black26,
        );
        for (final child in children) {
          _visitNode(child, spans, codeStyle);
        }
        break;

      case 'pre':
        final codeStyle = baseStyle?.copyWith(
          fontFamily: 'monospace',
          backgroundColor: Colors.black26,
        );
        for (final child in children) {
          _visitNode(child, spans, codeStyle);
        }
        spans.add(TextSpan(text: '\n\n', style: baseStyle));
        break;

      case 'ul':
      case 'ol':
        for (var i = 0; i < children.length; i++) {
          final child = children[i];
          if (child is md.Element && child.tag == 'li') {
            final bullet = node.tag == 'ul' ? '• ' : '${i + 1}. ';
            spans.add(TextSpan(text: bullet, style: baseStyle));
            for (final liChild in child.children ?? const <md.Node>[]) {
              _visitNode(liChild, spans, baseStyle);
            }
            spans.add(TextSpan(text: '\n', style: baseStyle));
          }
        }
        spans.add(TextSpan(text: '\n', style: baseStyle));
        break;

      case 'li':
        for (final child in children) {
          _visitNode(child, spans, baseStyle);
        }
        break;

      case 'a':
        final linkStyle = baseStyle?.copyWith(
          color: Colors.blueAccent,
          decoration: TextDecoration.underline,
        );
        for (final child in children) {
          _visitNode(child, spans, linkStyle);
        }
        break;

      case 'br':
        spans.add(TextSpan(text: '\n', style: baseStyle));
        break;
        
      default:
        for (final child in children) {
          _visitNode(child, spans, baseStyle);
        }
    }
  } else if (node is md.Text) {
    spans.add(TextSpan(text: node.text, style: baseStyle));
  }
}
