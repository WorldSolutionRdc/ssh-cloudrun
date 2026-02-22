#!/bin/bash
set -e

echo "=== Démarrage du serveur SSH sur port 443 ==="

# Créer l'utilisateur WorldSolution si les variables sont définies
if [ ! -z "$SSH_USER" ] && [ ! -z "$SSH_PASS" ]; then
    echo "Création de l'utilisateur $SSH_USER"
    adduser -D -s /bin/bash "$SSH_USER"
    echo "$SSH_USER:$SSH_PASS" | chpasswd
    
    # Configuration pour les tunnels
    echo "AllowTcpForwarding yes" >> /etc/ssh/sshd_config
    echo "GatewayPorts yes" >> /etc/ssh/sshd_config
    echo "PermitTunnel yes" >> /etc/ssh/sshd_config
    echo "ClientAliveInterval 30" >> /etc/ssh/sshd_config
    echo "ClientAliveCountMax 3" >> /etc/ssh/sshd_config
fi

# Démarrer SSH
echo "SSH démarré sur le port 443"
exec /usr/sbin/sshd -D -p 443 -e
