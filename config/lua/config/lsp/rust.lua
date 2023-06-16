local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
    return
end
lspconfig.rust_analyzer.setup({
    on_attach=on_attach_vim,
    settings = {
        ["rust-analyzer"] = {
          {
  experimental = {
    serverStatusNotification = true
  },
  general = {
    positionEncodings = { "utf-16" }
  },
  textDocument = {
    callHierarchy = {
      dynamicRegistration = false
    },
    codeAction = {
      codeActionLiteralSupport = {
        codeActionKind = {
          valueSet = { "", "quickfix", "refactor", "refactor.extract", "refactor.inline", "refactor.rewrite", "source", "source.organizeImports" }
        }
      },
      dataSupport = true,
      dynamicRegistration = true,
      isPreferredSupport = true,
      resolveSupport = {
        properties = { "edit" }
      }
    },
    completion = {
      completionItem = {
        commitCharactersSupport = false,
        deprecatedSupport = false,
        documentationFormat = { "markdown", "plaintext" },
        preselectSupport = true,
        snippetSupport = true
      },
      completionItemKind = {
        valueSet = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25 }
      },
      contextSupport = true,
      dynamicRegistration = true 
    },
    declaration = {
      linkSupport = true
    },
    definition = {
      dynamicRegistration = true,
      linkSupport = true
    },
    documentHighlight = {
      dynamicRegistration = false
    },
    documentSymbol = {
      dynamicRegistration = false,
      hierarchicalDocumentSymbolSupport = true,
      symbolKind = {
        valueSet = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26 }
      }
    },
    formatting = {
      dynamicRegistration = true
    },
    hover = {
      contentFormat = { "markdown", "plaintext" },
      dynamicRegistration = true
    },
    implementation = {
      linkSupport = true
    },
    inlayHint = {
      dynamicRegistration = false,
      resolveSupport = {
        properties = {}
      }
    },
    publishDiagnostics = {
      relatedInformation = true,
      tagSupport = {
        valueSet = { 1, 2 }
      }
    },
    rangeFormatting = {
      dynamicRegistration = true
    },
    references = {
      dynamicRegistration = false
    },
    rename = {
      dynamicRegistration = true,
      prepareSupport = true
    },
    semanticTokens = {
      augmentsSyntaxTokens = true,
      dynamicRegistration = false,
      formats = { "relative" },
      multilineTokenSupport = false,
      overlappingTokenSupport = true,
      requests = {
        full = {
          delta = true
        },
        range = false
      },
      serverCancelSupport = false,
      tokenModifiers = { "declaration", "definition", "readonly", "static", "deprecated", "abstract", "async", "modification", "documentation", "defaultLibrary" },
      tokenTypes = { "namespace", "type", "class", "enum", "interface", "struct", "typeParameter", "parameter", "variable", "property", "enumMember", "event", "function", "method", "macro", "keyword", "modifier", "comment", "string", "number", "regexp", "operator", "decorator" }
    },
    signatureHelp = {
      dynamicRegistration = false,
      signatureInformation = {
        activeParameterSupport = true,
        documentationFormat = { "markdown", "plaintext" },
        parameterInformation = {
          labelOffsetSupport = true
        }
      }
    },
    synchronization = {
      didSave = true,
      dynamicRegistration = false,
      willSave = true,
      willSaveWaitUntil = true
    },
    typeDefinition = {
      linkSupport = true
    }
  },
  window = {
    showDocument = {
      support = true
    },
    showMessage = {
      messageActionItem = {
        additionalPropertiesSupport = false
      }
    },
    workDoneProgress = true
  },
  workspace = {
    applyEdit = true,
    configuration = true,
    didChangeWatchedFiles = {
      dynamicRegistration = true,
      relativePatternSupport = true
    },
    inlayHint = {
      refreshSupport = true
    },
    semanticTokens = {
      refreshSupport = true
    },
    symbol = {
      dynamicRegistration = false,
      hierarchicalWorkspaceSymbolSupport = true,
      symbolKind = {
        valueSet = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26 }
      }
    },
    workspaceEdit = {
      resourceOperations = { "rename", "create", "delete" }
    },
    workspaceFolders = true
  }
}
        }
    }
})
