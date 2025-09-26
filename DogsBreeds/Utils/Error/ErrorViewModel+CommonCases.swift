extension ErrorViewModel {
    static func makeNoConnection() -> Self {
        .init(title: "Ops, sem internet",
              message: "Verifique sua conexão e tente novamente.",
              buttonTitle: "Recarregar")
    }
    
    static func makeGeneric() -> Self {
        .init(title: "Ops, encontramos um problema",
              message: "Houve um problema ao buscar a lista de raças, tente novamente.",
              buttonTitle: "Recarregar")
    }
}
